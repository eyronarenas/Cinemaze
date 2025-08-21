import 'package:go_router/go_router.dart';
import '../features/home/home_screen.dart';
import '../features/search/search_screen.dart';
import '../features/watchlist/watchlist_screen.dart';
import '../features/details/details_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/search', builder: (_, __) => const SearchScreen()),
    GoRoute(path: '/watchlist', builder: (_, __) => const WatchlistScreen()),
    GoRoute(path: '/details/:id', builder: (ctx, st) {
      final id = int.parse(st.pathParameters['id']!);
      final title = st.uri.queryParameters['title'];
      final poster = st.uri.queryParameters['poster'];
      final overview = st.uri.queryParameters['overview'];
      final rating = double.tryParse(st.uri.queryParameters['rating'] ?? '0') ?? 0;
      final type = st.uri.queryParameters['type'] ?? 'movie';
      return DetailsScreen(
        id: id,
        title: title ?? '',
        posterPath: poster,
        overview: overview,
        rating: rating,
        type: type,
      );
    }),
  ],
);
