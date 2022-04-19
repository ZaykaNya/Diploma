import 'dart:convert';
import 'package:diplom/models/user.dart';
import 'package:diplom/models/log.dart';
import 'package:http/http.dart' as http;

/// Fetches all users
Future<List<UserInfo>> fetchAllUsers() async {
  final response =
      await http.get(Uri.parse('http://semantic-portal.net/log/api/user'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<UserInfo>((json) => UserInfo.fromMap(json)).toList();
  } else {
    throw Exception("Failed to fetch all users");
  }
}

/// Fetches specific user by id
Future<User> fetchUserDetailsById(id) async {
  final response = await http
      .get(Uri.parse('http://semantic-portal.net/log/api/user/$id/details'));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch user by id $id");
  }
}

/// Fetches all logs of user by user id
Future<List<UserLog>> fetchUserLogsById(id) async {
  final response =
      await http.get(Uri.parse('http://semantic-portal.net/log/api/user/$id'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<UserLog>((json) => UserLog.fromMap(json)).toList();
  } else {
    throw Exception("Failed to fetch user logs by id $id");
  }
}

/// Fetches user logs from selected time by user id
Future<List<UserLog>> fetchUserLogsFromTime(id, time) async {
  final response = await http
      .get(Uri.parse('http://semantic-portal.net/log/api/user/$id/from/$time'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<UserLog>((json) => UserLog.fromMap(json)).toList();
  } else {
    throw Exception("Failed to fetch user logs by id $id");
  }
}

/// Fetches user logs between selected time by user id
Future<List<UserLog>> fetchUserLogsBetweenTime(id, time1, time2) async {
  final response = await http.get(Uri.parse(
      'http://semantic-portal.net/log/api/user/$id/between/$time1/$time2'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<UserLog>((json) => UserLog.fromMap(json)).toList();
  } else {
    throw Exception("Failed to fetch user logs by id $id");
  }
}
