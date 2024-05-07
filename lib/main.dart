import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/theme/app_theme.dart';
import 'features/search/domain/repository/data_repository.dart';
import 'features/home/home_page.dart';
import 'features/search/presentation/bloc/repo_search_bloc.dart';

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