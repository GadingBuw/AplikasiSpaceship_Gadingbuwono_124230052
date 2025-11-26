class Report {
  final int id;
  final String title;
  final String imageUrl;
  final String summary;
  final String publishedAt;
  final String newsSite;
  final String url;

  Report({
    required this.id, required this.title, required this.imageUrl,
    required this.summary, required this.publishedAt, required this.newsSite, required this.url,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'] ?? '',
      summary: json['summary'] ?? '',
      publishedAt: json['published_at'],
      newsSite: json['news_site'] ?? '',
      url: json['url'],
    );
  }
}