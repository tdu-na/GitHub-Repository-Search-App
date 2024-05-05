import 'package:equatable/equatable.dart';
import 'package:github_repo_search/features/search/data/repo_data_model.dart';

abstract class RepoSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitialState extends RepoSearchState {}

class SearchLoadingState extends RepoSearchState {}

class SearchLoadedState extends RepoSearchState {
  final List<RepoDataModel> repos;

  SearchLoadedState(this.repos);

  @override
  List<Object?> get props => [repos];
}

class SearchErrorState extends RepoSearchState {
  final String message;

  SearchErrorState(this.message);

  @override
  List<Object?> get props => [message];