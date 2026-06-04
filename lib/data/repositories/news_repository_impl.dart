import 'package:nuze_app/core/utils/api_runner.dart';
import 'package:nuze_app/core/utils/result.dart';
import 'package:nuze_app/domain/repository/news_repository.dart';
import '../../domain/entities/article.dart';
import '../services/news_api_service.dart';
import '../services/gnews_service.dart';

class NewsRepositoryImpl with ApiRunner implements NewsRepository {
  final NewsApiService newsApi;
  final GNewsService gNews;

  NewsRepositoryImpl(this.newsApi, this.gNews);

  @override
  Future<Result<List<Article>>> getBreakingNews() async {
    return runApiTask(() async {
      return await newsApi.fetchBreakingList();
    });
  }

  @override
  Future<Result<List<Article>>> getNormalNews() async {
    return runApiTask(() async {
      return await gNews.fetchNews();
    });
  }

  @override
  Future<Result<List<Article>>> searchNews(String query) async {
    return runApiTask(() async {
      return await newsApi.searchArticles(query);
    });
  }
}
