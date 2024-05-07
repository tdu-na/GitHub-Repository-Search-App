import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_theme.dart';
import 'services/data_repository.dart';
import 'home_page.dart';
import 'repo_search_bloc.dart';

void main() {
  runApp(
    BlocProvider<RepoSearchBloc>(
      create: (context) => RepoSearchBloc(DataRepository()),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Search',
      theme: AppTheme.darkTheme,
      home: BlocProvider(
        create: (context) => RepoSearchBloc(DataRepository()),
        child: Home(),
      ),
    );
  }
}