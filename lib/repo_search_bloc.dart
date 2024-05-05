import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repo_search/features/search/domain/repository/data_repository.dart';
import 'repo_search_event.dart';
import 'repo_search_state.dart';

class RepoSearchBloc extends Bloc<RepoSearchEvent, RepoSearchState> {
  final DataRepository _dataRepository;

  RepoSearchBloc(this._dataRepository) : super(SearchInitialState()) {
    on<SearchQueryChanged>((event, emit) async {
      emit(SearchLoadingState());
      try {
        final repos =
            await _dataRepository.getRepositoriesWithSearchQuery(event.query);
        repos.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        emit(SearchLoadedState(repos));
      } catch (e) {
        emit(SearchErrorState(e.toString()));
      }
    });

    on<SearchRefreshRequested>((event, emit) async {
      try {
        final repos = await _dataRepository.getTrendingRepositories();
        emit(SearchLoadedState(repos));
      } catch (e) {
        emit(SearchErrorState(e.toString()));
      }
    });

    on<ClearSearch>((event, emit) {
      emit(SearchInitialState());
    });
  }
}