class Issue {
  final String title;
  final DateTime createdAt;

  Issue({required this.title, required this.createdAt});

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      title: json['title'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}