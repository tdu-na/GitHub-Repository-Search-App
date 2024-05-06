import 'package:flutter/material.dart';
import 'package:github_repo_search/core/utils/constants/app_strings.dart';
import 'package:github_repo_search/features/detail/data/issue_data_model.dart';
import 'package:github_repo_search/features/detail/domain/repository/details_page_repository.dart';
import 'package:github_repo_search/features/search/data/repo_data_model.dart';

class DetailsPage extends StatelessWidget {
  final RepoDataModel repo;

  const DetailsPage({required this.repo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailsPageRepository dataRepository = DetailsPageRepository();

    return Scaffold(
      appBar: AppBar(
        title: Text(repo.name),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(repo.name, style: Theme.of(context).textTheme.titleLarge),
                    Text('Owner: ${repo.owner}', style: Theme.of(context).textTheme.titleMedium),
                    Text('Language: ${repo.language}', style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(height: 8),
                    Text('Description: ${repo.description}', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              Divider(),
              FutureBuilder<List<Issue>>(
                future: dataRepository.fetchOpenIssues(repo.owner, repo.name),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error.toString()}'));
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final issues = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: issues.map((issue) => ListTile(
                          title: Text(issue.title),
                          subtitle: Text('Created at: ${issue.createdAt}'),
                        )).toList(),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppStrings.noOpenIssues),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}