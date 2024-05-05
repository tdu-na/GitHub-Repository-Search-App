import 'package:github_repo_search/features/detail/data/issue_data_model.dart';
import 'dart:convert' show json, utf8;
import 'dart:async';
import 'package:http/http.dart' as http;

class DetailsPageRepository {
  Future<List<Issue>> fetchOpenIssues(String owner, String name) async {
    final Uri url = Uri.parse(
        'https://api.github.com/repos/$owner/$name/issues?state=open');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> issuesJson =
          json.decode(response.body) as List<dynamic>;
      final issues = issuesJson
          .map((dynamic issueJson) =>
              Issue.fromJson(issueJson as Map<String, dynamic>))
          .toList();
      issues.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return issues;
    } else {
      throw Exception('Failed to load issues');
    }
  }
}