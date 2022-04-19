import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diplom/models/course.dart';

/// Fetches all courses
Future<List<ShortCourse>> fetchAllCourses() async {
  final response =
      await http.get(Uri.parse('http://semantic-portal.net/log/api/course'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<ShortCourse>((json) => ShortCourse.fromJson(json)).toList();
  } else {
    throw Exception("Failed to fetch all courses");
  }
}

/// Fetches information about specific course
Future<Course> fetchCoursesByName(course) async {
  final response =
      await http.get(Uri.parse('http://semantic-portal.net/log/api/course/$course'));

  if (response.statusCode == 200) {
    return Course.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch information about course: $course");
  }
}
