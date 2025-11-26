class Article {
  final int id;
  final String title;
  final String url;
  final String imageUrl;
  final String summary;
  final String publishedAt;
  final String newsSite;

  Article({
    required this.id,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.summary,
    required this.publishedAt,
    required this.newsSite,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      imageUrl: json['image_url'] ?? '',
      summary: json['summary'] ?? 'No summary available',
      publishedAt: json['published_at'],
      newsSite: json['news_site'] ?? '',
    );
  }
}