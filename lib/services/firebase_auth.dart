import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/user_model.dart';
import '../bases/auth_base.dart';

class FirebaseAuthentication implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  UserModel? userFromFirebase(User? user) {
    if (user != null) {
      return UserModel(uid: user.uid, email: user.email, name: user.displayName, photo: user.photoURL, username: 'user${user.email}');
    } else {
      return null;
    }
  }

  @override
  Future<UserModel?> currentUser() async {
    try {
      return userFromFirebase(_firebaseAuth.currentUser);
    } catch (e) {
      print('An error has been occurred while trying to reach current user' + e.toString());
      return null;
    }
  }

  @override
  Future<UserModel?> signIn() async {
    var _usercred = await _firebaseAuth.signInAnonymously();
    return userFromFirebase(_usercred.user);
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      var _googleuser = await _googleSignIn.signIn();

      if (_googleuser != null) {
        var _googleauth = await _googleuser.authentication;
        if (_googleauth.idToken != null && _googleauth.accessToken != null) {
          var _response =
              await _firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(idToken: _googleauth.idToken, accessToken: _googleauth.accessToken));
          return userFromFirebase(_response.user);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('error' + e.toString());
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print('An error has been occurred while trying to signout' + e.toString());
      return false;
    }
  }

  @override
  Future<UserModel?> createUserWithEmail(String? email, String? password) async {
    var _userCred = await _firebaseAuth.createUserWithEmailAndPassword(email: email!, password: password!);
    return userFromFirebase(_userCred.user);
  }

  @override
  Future<UserModel?> signInWithEmail(String? email, String? password) async {
    var _userCred = await _firebaseAuth.signInWithEmailAndPassword(email: email!, password: password!);
    if (_userCred.user != null) {
      return userFromFirebase(_userCred.user);
    } else {
      return null;
    }
  }
}
