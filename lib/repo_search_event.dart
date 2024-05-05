abstract class RepoSearchEvent {}

class SearchQueryChanged extends RepoSearchEvent {
  final String query;

  SearchQueryChanged(this.query);
}

class SearchRefreshRequested extends RepoSearchEvent {}

class ClearSearch extends RepoSearchEvent {}