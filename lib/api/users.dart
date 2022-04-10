import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> fetchAllUsers() {
  return http.get(Uri.parse('http://semantic-portal.net/log/api/user'),
      headers: {"Access-Control-Allow-Origin": "*"});
}

Future<http.Response> fetchUserDetailsById(id) {
  return http.get(
      Uri.parse('http://semantic-portal.net/log/api/user/$id/details'),
      headers: {"Access-Control-Allow-Origin": "*"});
}

Future<http.Response> fetchUserLogsById(id) {
  return http.get(Uri.parse('http://semantic-portal.net/log/api/user/$id'),
      headers: {"Access-Control-Allow-Origin": "*"});
}

Future<http.Response> fetchUserLogsFromTime(id, time) {
  return http.get(
      Uri.parse('http://semantic-portal.net/log/api/user/$id/from/$time'),
      headers: {"Access-Control-Allow-Origin": "*"});
}

Future<http.Response> fetchUserLogsBetweenTime(id, time1, time2) {
  return http.get(
      Uri.parse(
          'http://semantic-portal.net/log/api/user/$id/between/$time1/$time2'),
      headers: {"Access-Control-Allow-Origin": "*"});
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

Future<Album> fetchTestData() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load test data');
  }
}
