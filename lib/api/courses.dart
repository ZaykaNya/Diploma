import 'package:http/http.dart' as http;

Future<http.Response> fetchAllCourses() {
  return http.get(Uri.parse('http://semantic-portal.net/log/api/course'),
      headers: {"Access-Control-Allow-Origin": "*"});
}

Future<http.Response> fetchCoursesByName(course) {
  return http.get(
      Uri.parse('http://semantic-portal.net/log/api/course/$course'),
      headers: {"Access-Control-Allow-Origin": "*"});
}
