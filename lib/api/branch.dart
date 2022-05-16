import 'dart:convert';
import 'package:diplom/models/branch.dart';
import 'package:http/http.dart' as http;

/// Fetches specific page ingo by branch name
Future<Page> fetchPageByBranch(branch) async {
  final response =
  await http.get(Uri.parse('http://semantic-portal.net/api/branch/$branch/view'));

  if (response.statusCode == 200) {
    return Page.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch page $branch");
  }
}

/// Fetches children of page by branch name
Future<List<Page>> fetchPageChildrenByBranch(branch) async {
  final response =
  await http.get(Uri.parse('http://semantic-portal.net/api/branch/$branch/children'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Page>((json) => Page.fromJson(json)).toList();
  } else {
    throw Exception("Failed to fetch all users");
  }
}