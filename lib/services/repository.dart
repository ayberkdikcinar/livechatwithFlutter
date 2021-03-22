import '../model/user_model.dart';
import '../bases/auth_base.dart';
import 'firebase_auth.dart';
import '../components/locator/locator.dart';
import 'firestore_db_service.dart';

//enum STATUS { DEBUG, RELEASE}

class UserRepository implements AuthBase {
  //STATUS status = STATUS.DEBUG;

  final FirebaseAuthentication? _firebaseAuthentication = locator<FirebaseAuthentication>();
  final FirestoreDBService _firestore = locator<FirestoreDBService>();
  @override
  Future<UserModel?> currentUser() async {
    try {
      return await _firebaseAuthentication!.currentUser();
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
      await _firestore.addUser(_recentuser!);
      return _recentuser;
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
    try {
      var _recentuser = await _firebaseAuthentication!.createUserWithEmail(email, password);
      var _ans = await _firestore.addUser(_recentuser!);
      if (_ans) {
        return _recentuser;
      } else {
        return null;
      }
    } catch (e) {
      print('error' + e.toString());
      return null;
    }
  }

  @override
  Future<UserModel?> signInWithEmail(String? email, String? password) async {
    try {
      return await _firebaseAuthentication!.signInWithEmail(email, password);
    } catch (e) {
      print('error' + e.toString());
      return null;
    }
  }
}
