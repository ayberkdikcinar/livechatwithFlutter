import '../bases/base_model.dart';

class UserModel extends BaseModel {
  String? uid;
  String? username;
  String? name;
  String? photo;
  String? timestamp;
  String? email;

  UserModel({
    required this.uid,
    this.username,
    this.name,
    this.photo,
    this.timestamp,
    required this.email,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'] ?? '';
    photo = json['photo'] ?? 'https://i.pinimg.com/originals/ed/c7/5e/edc75e41888082aa8323c725540624f5.jpg';
    username = json['username'] ?? '';
    email = json['email'];
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name ?? '';
    data['photo'] = photo ?? 'https://i.pinimg.com/originals/ed/c7/5e/edc75e41888082aa8323c725540624f5.jpg';
    data['username'] = username ?? '';
    data['email'] = email;
    return data;
  }

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }
}
