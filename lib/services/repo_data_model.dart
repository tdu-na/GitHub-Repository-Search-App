class RepoDataModel {
  final String htmlUrl;
  final int watchersCount;
  final String language;
  final String description;
  final String name;
  final String owner;

  RepoDataModel({
    required this.htmlUrl,
    required this.watchersCount,
    required this.language,
    required this.description,
    required this.name,
    required this.owner,
  });

  static List<RepoDataModel> mapJSONStringToList(List<dynamic> jsonList) {
    return jsonList.map((r) => RepoDataModel(
      htmlUrl: r['html_url'] as String? ?? '',
      watchersCount: r['watchers_count'] as int? ?? 0,
      language: r['language'] as String? ?? 'Unknown',
      description: r['description'] as String? ?? 'No description',
      name: r['name'] as String? ?? 'Unnamed',
      owner: r['owner']['login'] as String? ?? 'Unknown owner',
    )).toList();
  }
}