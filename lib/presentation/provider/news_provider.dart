import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nuze_app/core/utils/result.dart';
import '../../../domain/entities/article.dart';
import '../../../domain/usecases/get_news_usecase.dart';

class NewsProvider extends ChangeNotifier {
  final GetNewsUseCase useCase;

  NewsProvider(this.useCase);

  List<Article> breaking = []; // ← now a list, not a single Article?
  List<Article> normal = [];

  bool isLoading = false;
  String? error;
  Future<void> fetchAll() async {
    isLoading = true;

    error = null;

    notifyListeners();

    final results = await Future.wait([
      useCase.getBreaking(),

      useCase.getNormal(),
    ]);

    final breakingResult = results[0];

    final normalResult = results[1];

    // BREAKING NEWS
    if (breakingResult is Success<List<Article>>) {
      breaking = breakingResult.data;
    } else if (breakingResult is Error<List<Article>>) {
      error = breakingResult.failure.message;
    }

    // NORMAL NEWS
    if (normalResult is Success<List<Article>>) {
      normal = normalResult.data;
    } else if (normalResult is Error<List<Article>>) {
      error = normalResult.failure.message;
    }

    isLoading = false;

    notifyListeners();
  }
}
