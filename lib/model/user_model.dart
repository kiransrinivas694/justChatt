import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? email;
  String? username;

  UserModel({this.email, this.username});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'] as String?,
        username: json['username'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
      };
}
