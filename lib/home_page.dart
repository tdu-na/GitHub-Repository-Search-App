import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repo_search/core/utils/constants/app_strings.dart';
import 'package:github_repo_search/features/detail/presentation/detail_page.dart';
import 'package:github_repo_search/features/search/presentation/pages/search_page.dart';
import 'package:github_repo_search/features/search/presentation/bloc/repo_search_bloc.dart';
import 'package:github_repo_search/features/search/presentation/bloc/repo_search_event.dart';
import 'package:github_repo_search/features/search/presentation/bloc/repo_search_state.dart';
import '../search/presentation/pages/github_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RepoSearchBloc>().add(SearchRefreshRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appBarTitleHome),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value:
                        BlocProvider.of<RepoSearchBloc>(context, listen: false),
                    child: SearchPage(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<RepoSearchBloc, RepoSearchState>(
        builder: (context, state) {
          if (state is SearchLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchLoadedState) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<RepoSearchBloc>().add(SearchRefreshRequested());
              },
              child: ListView.builder(
                itemCount: state.repos.length,
                itemBuilder: (BuildContext context, int index) {
                  final repo = state.repos[index];
                  return GithubItem(
                    repo: repo,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(repo: repo),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is SearchErrorState) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text(AppStrings.pullToRefresh));
        },
      ),
    );
  }
}