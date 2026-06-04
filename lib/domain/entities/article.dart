class Article {
  final String title;
  final String? imageUrl;
  final String? source;
  final String? description; // ← added
  final DateTime publishedAt;

  const Article({
    required this.title,
    this.imageUrl,
    this.source,
    this.description,
    required this.publishedAt,
  });

  //   @override
  //   bool operator ==(Object other) =>
  //       identical(this, other) ||
  //       other is Article &&
  //           title == other.title &&
  //           publishedAt == other.publishedAt;

  //   @override
  //   int get hashCode => Object.hash(title, publishedAt);

  //   @override
  //   String toString() =>
  //       'Article(title: $title, source: $source, publishedAt: $publishedAt)';
}
