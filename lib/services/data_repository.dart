import 'package:github_repo_search/features/search/data/github_api_service.dart';
import 'package:github_repo_search/features/search/data/repo_data_model.dart';

class DataRepository {
  Future<List<RepoDataModel>> getTrendingRepositories() => GithubApiService.getTrendingRepositories();

  Future<List<RepoDataModel>> getRepositoriesWithSearchQuery(String query) =>
      GithubApiService.getRepositoriesWithSearchQuery(query);
}