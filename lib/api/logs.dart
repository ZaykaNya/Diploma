import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diplom/models/log.dart';

/// Fetches all logs
Future<List<UserLog>> fetchAllLogs() async {
  final response =
      await http.get(Uri.parse('http://semantic-portal.net/log/api/log'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<UserLog>((json) => UserLog.fromMap(json)).toList();
  } else {
    throw Exception("Failed to fetch all logs");
  }
}

/// Fetches all logs from selected time
Future<List<UserLog>> fetchLogsFromTime(time) async {
  final response = await http
      .get(Uri.parse('http://semantic-portal.net/log/api/log/from/$time'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<UserLog>((json) => UserLog.fromMap(json)).toList();
  } else {
    throw Exception("Failed to fetch all logs");
  }
}

/// Fetches all logs between selected time
Future<List<UserLog>> fetchLogsBetweenTime(time1, time2) async {
  final response = await http
      .get(Uri.parse('http://semantic-portal.net/log/api/log/between/$time1/$time2'));

  if (response.statusCode == 200) {
    print(json.decode(response.body)[0]);
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<UserLog>((json) => UserLog.fromMap(json)).toList();
  } else {
    throw Exception("Failed to fetch all logs");
  }
}
