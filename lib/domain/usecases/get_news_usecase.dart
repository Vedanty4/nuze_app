import 'package:nuze_app/core/utils/result.dart';
import 'package:nuze_app/domain/repository/news_repository.dart';
import '../entities/article.dart';

class GetNewsUseCase {
  final NewsRepository repo;

  GetNewsUseCase(this.repo);

  Future<Result<List<Article>>> getBreaking() => repo.getBreakingNews();
  Future<Result<List<Article>>> getNormal() => repo.getNormalNews();
  Future<Result<List<Article>>> search(String query) =>
      repo.searchNews(query); // ← new
}
