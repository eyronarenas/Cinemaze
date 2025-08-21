import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/catalog_repository.dart';
import '../../data/tmdb_api.dart';
import '../common/widgets.dart';
import 'package:go_router/go_router.dart';

final _tmdbProvider = Provider<TmdbApi>((_) => TmdbApi());
final _catalogProvider = Provider<CatalogRepository>((ref) => CatalogRepository(ref.watch(_tmdbProvider)));
final queryProvider = StateProvider<String>((_) => '');
final resultsProvider = FutureProvider.autoDispose((ref) async {
  final q = ref.watch(queryProvider);
  if (q.trim().isEmpty) return null;
  return ref.watch(_catalogProvider).searchMulti(q);
});

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final q = ref.watch(queryProvider);
    final results = ref.watch(resultsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Movies, TV shows, anime...'),
            onChanged: (v) => ref.read(queryProvider.notifier).state = v,
          ),
          const SizedBox(height: 16),
          if (q.isEmpty) const Text('Type to search…'),
          if (q.isNotEmpty)
            Expanded(
              child: results.when(
                data: (paged) {
                  if (paged == null || paged.results.isEmpty) {
                    return const Center(child: Text('No results'));
                  }
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 2/3, mainAxisSpacing: 12, crossAxisSpacing: 12),
                    itemCount: paged.results.length,
                    itemBuilder: (ctx, i) {
                      final m = paged.results[i];
                      return PosterCard(
                        posterPath: m.posterPath,
                        title: m.title,
                        rating: m.rating,
                        onTap: () => context.go('/details/${m.id}?title=${Uri.encodeComponent(m.title)}'
                            '&poster=${Uri.encodeComponent(m.posterPath ?? '')}'
                            '&overview=${Uri.encodeComponent(m.overview ?? '')}'
                            '&rating=${m.rating}'
                            '&type=${m.type.name}'),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
            ),
        ]),
      ),
    );
  }
}
