import 'dart:io';

import '../bases/auth_base.dart';
import '../components/locator/locator.dart';
import '../model/message_model.dart';
import '../model/user_model.dart';
import 'firebase_auth.dart';
import 'firebase_storage_service.dart';
import 'firestore_db_service.dart';

//enum STATUS { DEBUG, RELEASE}

class UserRepository implements AuthBase {
  //STATUS status = STATUS.DEBUG;

  final FirebaseAuthentication? _firebaseAuthentication = locator<FirebaseAuthentication>();
  final FirestoreDBService _firestore = locator<FirestoreDBService>();
  final FirebaseStorageService _fbStorage = locator<FirebaseStorageService>();
  @override
  Future<UserModel?> currentUser() async {
    try {
      var _user = await _firebaseAuthentication!.currentUser();
      return _firestore.findUser(_user!.uid!);
    } catch (e) {
      print('error' + e.toString());
      return null;
    }
  }

  @override
  Future<UserModel?> signIn() async {
    try {
      return await _firebaseAuthentication!.signIn();
    } catch (e) {
      print('error' + e.toString());
      return null;
    }
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      var _recentuser = await _firebaseAuthentication!.signInWithGoogle();
      var _usr = await _firestore.findUser(_recentuser!.uid!);
      if (_usr == null) {
        await _firestore.addUser(_recentuser);
        return _recentuser;
      } else {
        return _usr;
      }
    } catch (e) {
      print('error' + e.toString());
      return null;
    }
  }

  @override
  Future<bool?> signOut() async {
    try {
      return await _firebaseAuthentication!.signOut();
    } catch (e) {
      print('error' + e.toString());
      return null;
    }
  }

  @override
  Future<UserModel?> createUserWithEmail(String? email, String? password) async {
    var _recentuser = await _firebaseAuthentication!.createUserWithEmail(email, password);
    var _ans = await _firestore.addUser(_recentuser!);
    if (_ans) {
      return _recentuser;
    } else {
      return null;
    }
  }

  @override
  Future<UserModel?> signInWithEmail(String? email, String? password) async {
    return await _firebaseAuthentication!.signInWithEmail(email, password);
  }

  Future<bool> updateUser(String userid, UserModel user) async {
    return await _firestore.updateUser(userid, user);
  }

  Future<String> uploadFile(String userid, File file) async {
    return await _fbStorage.uploadImage(userid, file);
  }

  Future<List<UserModel>> fetchAllUsers() async {
    return await _firestore.fetchAllUsers();
  }

  Stream<List<Message>> getAllMessagesBetween(String? receiverUserId, String? currentUserId) {
    return _firestore.getAllMessagesBetween(receiverUserId, currentUserId);
  }

  Future<bool> saveMessage(Message message) {
    return _firestore.saveMessage(message);
  }

  Future<List<UserModel>> getChattedUsers(String userid) {
    return _firestore.getChattedUsers(userid);
  }

  Future<Message> getLastMessageBetween(String? to, String? from) {
    return _firestore.getLastMessageBetween(to, from);
  }
}
