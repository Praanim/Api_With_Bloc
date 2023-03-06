import 'dart:convert';

import 'package:api_bloc/data/models/post_user_model.dart';
import 'package:api_bloc/data/models/user_models.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  String baseUrl = 'https://reqres.in';

//GET API METHOD
  Future<List<UserModel>> getUsersFromApi() async {
    final response = await http.get(Uri.parse('$baseUrl/api/users?'));
    if (response.statusCode == 200) {
      final jsonObject = response.body;
      final map = jsonDecode(jsonObject) as Map<String, dynamic>;
      final listofUsers = map['data'] as List<dynamic>;

      return listofUsers
          .map((json) => UserModel.fromMap(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

//POST API METHOD
  Future<PostUserModel> postData({
    required String name,
    required String job,
  }) async {
    final response = await http.post(Uri.parse('$baseUrl/api/users'),
        body: jsonEncode({
          "name": name,
          "job": job,
        }));
    if (response.statusCode == 201) {
      final mapofData = jsonDecode(response.body) as Map<String, dynamic>;
      return PostUserModel.fromMap(mapofData);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

//DELETE API METHOD<

  Future<Map<String, String>> deleteData({required UserModel userModel}) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/api/users/${userModel.id}'));
    if (response.statusCode == 204) {
      return {
        'title': "Delete operation Done (Status code = ${response.statusCode})",
        'body': "User ${userModel.first_Name} was deleted "
      };
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

// PUT API METHOD

  Future<String> putData({
    required UserModel user,
    required String job,
  }) async {
    final response = await http.put(Uri.parse('$baseUrl/api/users/${user.id}'),
        body: jsonEncode({
          "name": user.first_Name,
          "job": job,
        }));
    if (response.statusCode == 200) {
      final mapofData = jsonDecode(response.body) as Map<String, dynamic>;
      return mapofData['updatedAt'];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
