import 'package:nuze_app/core/utils/result.dart';

import '../entities/article.dart';

abstract class NewsRepository {
  Future<Result<List<Article>>> getBreakingNews(); // ← Article? → List<Article>
  Future<Result<List<Article>>> getNormalNews();
  Future<Result<List<Article>>> searchNews(String query); // ← new
}
