import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repo_search/core/utils/constants/app_strings.dart';
import 'package:github_repo_search/features/detail/presentation/detail_page.dart';
import 'package:github_repo_search/features/search/presentation/bloc/repo_search_bloc.dart';
import 'package:github_repo_search/features/search/presentation/bloc/repo_search_event.dart';
import 'package:github_repo_search/features/search/presentation/bloc/repo_search_state.dart';
import 'package:github_repo_search/features/search/presentation/pages/github_item.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchQueryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchQueryController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchQueryController.removeListener(_onSearchChanged);
    _searchQueryController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchQueryController.text;
    if (query.length >= 4) {
      context.read<RepoSearchBloc>().add(SearchQueryChanged(query));
    } else {
      context.read<RepoSearchBloc>().add(ClearSearch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchQueryController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: AppStrings.searchHintText,
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black),
          ),
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
      body: BlocConsumer<RepoSearchBloc, RepoSearchState>(
        listener: (context, state) {
          if (state is SearchErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (_searchQueryController.text.length < 4) {
            return Center(child: Text(AppStrings.typeToSearch));
          }
          if (state is SearchLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchLoadedState) {
            return ListView.builder(
              itemCount: state.repos.length,
              itemBuilder: (BuildContext context, int index) {
                final repo = state.repos[index];
                return GithubItem(
                  repo: repo,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DetailsPage(repo: repo)),
                    );
                  },
                );
              },
            );
          } else if (state is SearchErrorState) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text(AppStrings.typeToSearch));
        },
      ),
    );
  }
}