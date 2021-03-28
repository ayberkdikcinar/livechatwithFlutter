import 'package:cloud_firestore/cloud_firestore.dart';

import '../bases/database_base.dart';
import '../model/message_model.dart';
import '../model/user_model.dart';

class FirestoreDBService implements DBBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _userRefer = FirebaseFirestore.instance.collection('users');

  @override
  Future<bool> addUser(UserModel user) async {
    try {
      await _userRefer.doc(user.uid).set(user.toJson());
      return true;
    } catch (e) {
      print('an error while adding user to firestore' + e.toString());
      return false;
    }
  }

  @override
  Future<bool> updateUser(String userid, UserModel updateduser) async {
    var query = await _userRefer.where('username', isEqualTo: updateduser.username).get();
    if (query.docs.isNotEmpty && query.docs.first.id != userid) {
      print('username is already in use');
      return false;
    } else {
      await _userRefer.doc(userid).update(updateduser.toJson());
      return true;
    }
  }

  @override
  Future<UserModel?> findUser(String userid) async {
    var _doc = await _userRefer.doc(userid).get();
    if (_doc.exists) {
      var _usermap = _doc.data()!;
      return UserModel.fromJson(_usermap);
    } else {
      return null;
    }
  }

  @override
  Future<List<UserModel>> fetchAllUsers() async {
    var _doc = await _userRefer.get();
    var _user = _doc.docs.map((e) => UserModel.fromJson(e.data()!)).toList();
    if (_user.isNotEmpty) {
      return _user;
    } else {
      print('User list is empty');
      return [];
    }
  }

  @override
  Future<bool> saveMessage(Message mssg) async {
    try {
      await _firestore.collection('conversation').doc('${mssg.from}--${mssg.to}').collection('messages').doc().set(mssg.toJson());
      await _firestore.collection('conversation').doc('${mssg.from}--${mssg.to}').set({'sender': '${mssg.from}', 'receiver': '${mssg.to}'});
      mssg.isOwner = false;
      await _firestore.collection('conversation').doc('${mssg.to}--${mssg.from}').collection('messages').doc().set(mssg.toJson());
      // await _firestore.collection('conversation').doc('${mssg.to}--${mssg.from}').set({'sender': '${mssg.from}', 'receiver': '${mssg.to}'});
      return true;
    } catch (e) {
      print('an error has been occurred while saving message' + e.toString());
      return false;
    }
  }

  @override
  Stream<List<Message>> getAllMessagesBetween(String? to, String? from) {
    var _snapshots = _firestore.collection('conversation').doc('${from!}--${to!}').collection('messages').orderBy('date', descending: true).snapshots();
    return _snapshots.map((event) => event.docs.map((e) => Message.fromJson(e.data()!)).toList());
  }

  @override
  Future<List<UserModel>> getChattedUsers(String userid) async {
    var _doc = await _firestore.collection('conversation').where('sender', isEqualTo: userid).get();

    var userList = <UserModel>[];

    for (var _oneDoc in _doc.docs) {
      print(_oneDoc.get('receiver'));
      userList.add((await findUser(_oneDoc.get('receiver')))!);
    }
    return userList;
  }

  Future<Message> getLastMessageBetween(String? to, String? from) async {
    var _snapshots = await _firestore.collection('conversation').doc('${from!}--${to!}').collection('messages').orderBy('date', descending: true).get();
    return Message.fromJson(_snapshots.docs.first.data()!);
  }
}
