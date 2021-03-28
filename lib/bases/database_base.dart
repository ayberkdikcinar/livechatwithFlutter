import '../model/message_model.dart';
import '../model/user_model.dart';

abstract class DBBase {
  Future<bool> addUser(UserModel user);
  Future<bool> updateUser(String userid, UserModel updateduser);
  Future<UserModel?> findUser(String userid);
  Future<List<UserModel>> fetchAllUsers();
  Future<bool> saveMessage(Message mssg);
  Stream<List<Message>> getAllMessagesBetween(String? to, String? from);
  Future<List<UserModel>> getChattedUsers(String userid);
  //Future<bool> deleteUser(UserModel user); uid alınabilir?
}
