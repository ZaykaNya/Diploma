import 'dart:convert';
import 'package:diplom/models/auth_user.dart';
import 'package:http/http.dart' as http;

/// Fetches specific user by id
Future<AuthUser> checkLogin(login, password) async {
  final response = await http
      .post(Uri.parse('http://semantic-portal.net/api/user/check/$login/$password'));

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));

    return AuthUser.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to check user login");
  }
}