import 'package:livechat/model/user_model.dart';

abstract class DBBase {
  Future<bool> addUser(UserModel user);
  //Future<bool> updateUser(UserModel user); uid alınabilir?
  //Future<bool> deleteUser(UserModel user); uid alınabilir?

}
