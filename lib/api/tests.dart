import 'dart:convert';
import 'package:diplom/models/test.dart';
import 'package:diplom/models/mark.dart';
import 'package:http/http.dart' as http;

/// Fetches all tests results
Future<List<Test>> fetchAllTests() async {
  final response = await http
      .get(Uri.parse('http://semantic-portal.net/api/test-results/all'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Test>((json) => Test.fromJson(json)).toList();
  } else {
    throw Exception("Failed to fetch all test results");
  }
}

/// Fetches tests by course
Future<List<Test>> fetchTestsFromCourse(course) async {
  final response = await http
      .get(Uri.parse('http://semantic-portal.net/api/test-results/course/$course'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Test>((json) => Test.fromJson(json)).toList();
  } else {
    throw Exception("Failed to fetch all test results");
  }
}

/// Fetches tests by branch
Future<List<Test>> fetchTestsFromBranch(branch) async {
  final response = await http
      .get(Uri.parse('http://semantic-portal.net/api/test-results/branch/$branch'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Test>((json) => Test.fromJson(json)).toList();
  } else {
    throw Exception("Failed to fetch all test results");
  }
}

/// Fetches specific user tests by id
Future<List<Test>> fetchTestsByUserId(id) async {
  final response = await http
      .get(Uri.parse('http://semantic-portal.net/api/test-results/user/$id'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Test>((json) => Test.fromJson(json)).toList();
  } else {
    throw Exception("Failed to fetch all test results");
  }
}

/// Fetches specific user best course test mark by user id and course
Future<Mark> fetchUserBestCourseMarkById(id, course) async {
  final response = await http
      .get(Uri.parse('http://semantic-portal.net/api/test-results/user/$id/course/$course/mark'));

  if (response.statusCode == 200) {
    return Mark.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch user by id $id");
  }
}

/// Fetches specific user best branch test mark by user id and branch
Future<Mark> fetchUserBestBranchMarkById(id, branch) async {
  final response = await http
      .get(Uri.parse('http://semantic-portal.net/api/test-results/user/$id/branch/$branch/mark'));

  if (response.statusCode == 200) {
    return Mark.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch user by id $id");
  }
}


