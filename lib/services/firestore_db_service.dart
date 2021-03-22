import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livechat/bases/database_base.dart';
import 'package:livechat/model/user_model.dart';

class FirestoreDBService implements DBBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> addUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toJson());
      var _doc = await _firestore.doc('users/${user.uid}').get();
      var _userinfos = user.fromJson(_doc.data()!);
      print(_userinfos.email);
      return true;
    } catch (e) {
      print('an error while adding user to firestore' + e.toString());
      return false;
    }
  }
}
