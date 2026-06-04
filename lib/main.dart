import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:nuze_app/core/network/dio_client.dart';
import 'package:provider/provider.dart';

import 'data/services/news_api_service.dart';
import 'data/services/gnews_service.dart';
import 'data/repositories/news_repository_impl.dart';
import 'domain/usecases/get_news_usecase.dart';
import 'presentation/provider/news_provider.dart';
import 'presentation/provider/search_provider.dart';

import 'core/router/app_router.dart';

Future<void> main() async {
  final repo = NewsRepositoryImpl(
    NewsApiService(DioClient.dio),
    GNewsService(DioClient.dio),
  );
  final useCase = GetNewsUseCase(repo);
  await dotenv.load(fileName: ".env");

  print(dotenv.env['NewsApi']);
  print(dotenv.env['GNewsApi']);

  runApp(MyApp(useCase));
}

class MyApp extends StatelessWidget {
  final GetNewsUseCase useCase;

  const MyApp(this.useCase, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider(useCase)),
        ChangeNotifierProvider(create: (_) => SearchProvider(useCase)),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "News App",
        theme: ThemeData.light(),
        routerConfig: appRouter,
      ),
    );
  }
}
