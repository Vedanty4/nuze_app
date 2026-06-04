import 'package:dio/dio.dart';
import 'package:nuze_app/data/model/article_model.dart';

class NewsApiService {
  final Dio dio;

  NewsApiService(this.dio);

  Future<List<ArticleModel>> fetchBreakingList() async {
    final res = await dio.get(
      "https://newsapi.org/v2/top-headlines",
      queryParameters: {"language": "en", "pageSize": "5"},
    );

    final list = res.data['articles'] as List;
    return list.map((e) => ArticleModel.fromNewsApi(e)).toList();
  }

  Future<List<ArticleModel>> searchArticles(String query) async {
    final res = await dio.get(
      "https://newsapi.org/v2/everything",
      queryParameters: {
        "q": query,
        "language": "en",
        "sortBy": "publishedAt",
        "pageSize": "20",
      },
    );
    final list = res.data['articles'] as List;
    return list.map((e) => ArticleModel.fromNewsApi(e)).toList();
  }
}
