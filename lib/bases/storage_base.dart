import 'dart:io';

abstract class FBStorage {
  Future<String> uploadImage(String userid, File file);
}
