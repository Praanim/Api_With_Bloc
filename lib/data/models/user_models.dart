import 'dart:convert';

class UserModel {
  final int id;
  final String email;

  final String first_Name;
  final String last_Name;
  final String avatar;
  UserModel({
    required this.id,
    required this.email,
    required this.first_Name,
    required this.last_Name,
    required this.avatar,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'first_Name': first_Name,
      'last_Name': last_Name,
      'avatar': avatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      email: map['email'] ?? '',
      first_Name: map['first_name'] ?? '',
      last_Name: map['last_name'] ?? '',
      avatar: map['avatar'] ?? '',
    );
  }
}
