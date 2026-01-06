class GithubRepo {
  final String id;
  final String name;
  final int stars;
  final String url;

  GithubRepo({
    required this.id,
    required this.name,
    required this.stars,
    required this.url
  });

  // Database se data lene ke liye helper
  factory GithubRepo.fromMap(Map<String, dynamic> map) {
    return GithubRepo(
      id: map['id'],
      name: map['name_with_owner'],
      stars: map['stargazer_count'],
      url: map['url'],
    );
  }
}