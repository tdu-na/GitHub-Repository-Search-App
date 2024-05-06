import 'package:flutter/material.dart';
import 'package:github_repo_search/features/search/data/repo_data_model.dart';

class GithubItem extends StatelessWidget {
  final RepoDataModel repo;
  final VoidCallback onTap;

  GithubItem({required this.repo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        highlightColor: Colors.lightBlueAccent,
        splashColor: Colors.red,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(repo.name, style: Theme.of(context).textTheme.titleMedium),
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text(repo.description, style: Theme.of(context).textTheme.bodyMedium),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(repo.owner, textAlign: TextAlign.start, style: Theme.of(context).textTheme.bodyMedium),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.star, color: Colors.deepOrange),
                          Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text('${repo.watchersCount}', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(repo.language, textAlign: TextAlign.end, style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}