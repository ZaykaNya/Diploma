import 'package:http/http.dart' as http;

Future<http.Response> fetchAllLogs() {
  return http.get(Uri.parse('http://semantic-portal.net/log/api/log'),
      headers: {"Access-Control-Allow-Origin": "*"});
}

Future<http.Response> fetchLogsFromTime(time) {
  return http.get(
      Uri.parse('http://semantic-portal.net/log/api/log/from/$time'),
      headers: {"Access-Control-Allow-Origin": "*"});
}

Future<http.Response> fetchLogsBetweenTime(time1, time2) {
  return http.get(
      Uri.parse('http://semantic-portal.net/log/api/log/between/$time1/$time2'),
      headers: {"Access-Control-Allow-Origin": "*"});
}
