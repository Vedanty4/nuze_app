import 'package:dio/dio.dart';
import 'package:nuze_app/core/error/exception.dart';
import 'package:nuze_app/data/model/article_model.dart';

class GNewsService {
  final Dio dio;

  GNewsService(this.dio);

  Future<List<ArticleModel>> fetchNews() async {
    final res = await dio.get(
      "https://gnews.io/api/v4/top-headlines",
      queryParameters: {"country": "in", "lang": "en"},
    );
    if (res.statusCode != 200) {
      throw ServerException("Failed to fetch news");
    }
    // Froom json date (res.data) give me only aritcles as list
    final list = res.data['articles'] as List;

    return list.map((e) => ArticleModel.fromGNews(e)).toList();
    // converts every single json article into sing ArticleModel articel
  }
}
