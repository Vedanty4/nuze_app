import 'package:flutter/material.dart';

import '../../../core/utils/result.dart';
import '../../../domain/entities/article.dart';
import '../../../domain/usecases/get_news_usecase.dart';

class SearchProvider extends ChangeNotifier {
  final GetNewsUseCase useCase;

  SearchProvider(this.useCase);

  List<Article> results = [];

  bool isLoading = false;

  String? error;

  String lastQuery = '';

  Future<void> search(String query) async {
    // prevent empty or same query
    if (query.trim().isEmpty || query == lastQuery) {
      return;
    }

    isLoading = true;

    error = null;

    lastQuery = query;

    notifyListeners();

    final result = await useCase.search(query);

    // SUCCESS CASE
    if (result is Success<List<Article>>) {
      results = result.data;
    }
    // ERROR CASE
    else if (result is Error<List<Article>>) {
      error = result.failure.message;
    }

    isLoading = false;

    notifyListeners();
  }

  void clear() {
    results = [];

    error = null;

    lastQuery = '';

    notifyListeners();
  }
}
