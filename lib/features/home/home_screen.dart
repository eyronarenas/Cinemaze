import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/media.dart';
import '../../data/repositories/catalog_repository.dart';
import '../../data/tmdb_api.dart';
import '../common/widgets.dart';
import 'sections.dart';
import 'package:go_router/go_router.dart';

final tmdbApiProvider = Provider<TmdbApi>((_) => TmdbApi());
final catalogRepoProvider = Provider<CatalogRepository>((ref) => CatalogRepository(ref.watch(tmdbApiProvider)));

final trendingProvider = FutureProvider((ref) => ref.watch(catalogRepoProvider).trending());
final popularMoviesProvider = FutureProvider((ref) => ref.watch(catalogRepoProvider).popularMovies());
final popularTvProvider = FutureProvider((ref) => ref.watch(catalogRepoProvider).popularTv());

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cinemaze'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () => context.go('/search')),
          IconButton(icon: const Icon(Icons.bookmark), onPressed: () => context.go('/watchlist')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Section(title: 'Trending', asyncData: ref.watch(trendingProvider)),
          const SizedBox(height: 16),
          Section(title: 'Popular Movies', asyncData: ref.watch(popularMoviesProvider)),
          const SizedBox(height: 16),
          Section(title: 'Popular TV', asyncData: ref.watch(popularTvProvider)),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
