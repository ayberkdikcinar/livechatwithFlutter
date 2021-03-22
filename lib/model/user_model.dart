import '../bases/base_model.dart';

class UserModel extends BaseModel {
  String? uid;
  String? username;
  String? name;
  String? photo;
  String? timestamp;
  String? email;

  UserModel({required this.uid, required this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] ?? '';
    name = json['name'] ?? '';
    photo = json['photo'] ?? ' ';
    username = json['username'] ?? '';
    email = json['email'] ?? '';
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid ?? '';
    data['name'] = name ?? '';
    data['photo'] = photo ?? '';
    data['username'] = username ?? '';
    data['email'] = email ?? '';
    return data;
  }

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }
}
