import 'package:go_router/go_router.dart';
import 'package:nuze_app/domain/entities/article.dart';
import 'package:nuze_app/presentation/screens/article_detail_screen.dart';
import 'package:nuze_app/presentation/screens/home_screen.dart';
import 'package:nuze_app/presentation/screens/news_screen.dart';

final GoRouter appRouter  = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/article',
      name: 'article',
      builder: (context, state) {
        final article = state.extra as Article;
        return ArticleDetailScreen(article: article);
      },
    ),
    GoRoute(
      path: '/search',
      name: 'search',
      builder: (context, state) => const SearchScreen(),
    ),
  ],
);