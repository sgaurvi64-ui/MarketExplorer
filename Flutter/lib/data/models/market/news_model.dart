class NewsModel {
  const NewsModel({
    required this.title,
    required this.source,
    required this.publishedAt,
  });

  final String title;
  final String source;
  final DateTime publishedAt;
}
