import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/common/widgets.dart';
import '../../main.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailsScreen extends ConsumerWidget {
  final int id;
  final String title;
  final String? posterPath;
  final String? overview;
  final double rating;
  final String type; // 'movie' or 'tv'
  const DetailsScreen({super.key, required this.id, required this.title, this.posterPath, this.overview, required this.rating, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlist = ref.watch(watchlistRepoProvider);
    final isSaved = watchlist.contains(id);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await watchlist.toggle(id);
          (context as Element).markNeedsBuild();
        },
        icon: Icon(isSaved ? Icons.bookmark_remove : Icons.bookmark_add),
        label: Text(isSaved ? 'Remove' : 'Watchlist'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 16/9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(posterUrl(posterPath, size: 'w780'), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.star, size: 18),
              const SizedBox(width: 6),
              Text(rating.toStringAsFixed(1)),
              const Spacer(),
              Text(type.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          Text(overview ?? 'No overview available.'),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () async {
              // Open YouTube search for trailers by title (legal, simple)
              final q = Uri.encodeComponent('$title trailer');
              await launchUrlString('https://www.youtube.com/results?search_query=$q', mode: LaunchMode.externalApplication);
            },
            icon: const Icon(Icons.play_circle),
            label: const Text('Watch Trailer'),
          ),
        ],
      ),
    );
  }
}
