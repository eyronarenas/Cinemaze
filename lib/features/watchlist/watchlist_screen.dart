import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/catalog_repository.dart';
import '../../data/tmdb_api.dart';
import '../../main.dart';


final _tmdbProvider = Provider<TmdbApi>((_) => TmdbApi());
final _catalogProvider = Provider<CatalogRepository>((ref) => CatalogRepository(ref.watch(_tmdbProvider)));

class WatchlistScreen extends ConsumerWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(_catalogProvider);
    final watchlist = ref.watch(watchlistRepoProvider).getIds();

    return Scaffold(
      appBar: AppBar(title: const Text('Watchlist')),
      body: FutureBuilder(
        future: repo.trending(), // simple: reuse trending to get Media shape; then filter by ids
        builder: (ctx, snap) {
          // NOTE: For a real app, fetch by IDs via /movie/{id} or /tv/{id}.
          // To keep this lean, we’ll just show IDs saved (cannot fetch each by ID without many calls).
          if (watchlist.isEmpty) return const Center(child: Text('Your watchlist is empty.'));
          // Placeholder grid of IDs only:
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: watchlist.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, i) => ListTile(
              leading: const Icon(Icons.bookmark),
              title: Text('Item ID: ${watchlist[i]}'),
              subtitle: const Text('Open details from Home/Search to see posters.'),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
