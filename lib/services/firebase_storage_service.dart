import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../bases/storage_base.dart';

class FirebaseStorageService implements FBStorage {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<String> uploadImage(String userid, File file) async {
    var _puttingfile = _firebaseStorage.ref().child(userid).child('profile_photo').putFile(file);
    var _url = await (await _puttingfile).ref.getDownloadURL();
    return _url;
  }
}
