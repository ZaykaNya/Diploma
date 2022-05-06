import 'dart:async';
import 'dart:convert';
import 'package:diplom/api/users.dart';
import 'package:diplom/models/auth_user.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/models/user.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  AuthUser? _user;

  Future<AuthUser?> getUser(login, password) async {
    final response = await http.post(
        Uri.parse('http://semantic-portal.net/api/user/check/$login/$password'),
    );

    if(jsonDecode(response.body)["login"] == true) {
      return Future.delayed(
        const Duration(milliseconds: 300),
            () => _user = AuthUser(id: jsonDecode(response.body)["id"], login: "-", role: "-"),
      );
    }
  }

  Future<User> getUserById(id) async {
    return fetchUserDetailsById(id);
  }

  Future<List<UserLog>> getUserLogsById(id) async {
    return fetchUserLogsById(id);
  }
}
