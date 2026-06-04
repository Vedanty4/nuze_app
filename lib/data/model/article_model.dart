import '../../domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel({
    required super.title,
    required super.imageUrl,
    required super.source,
    required super.publishedAt,
  });

  factory ArticleModel.fromNewsApi(json) {
    return ArticleModel(
      title: json['title'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      source: json['source']?['name'] ?? '',
      publishedAt:
          DateTime.tryParse(json['publishedAt'] ?? '') ?? DateTime.now(),
    );
  }

  factory ArticleModel.fromGNews(json) {
    return ArticleModel(
      title: json['title'] ?? '',
      imageUrl: json['image'] ?? '',
      source: json['source']?['name'] ?? '',
      publishedAt:
          DateTime.tryParse(json['publishedAt'] ?? '') ?? DateTime.now(),
    );
  }
}
