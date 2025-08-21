import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/media.dart';
import '../common/widgets.dart';
import 'package:go_router/go_router.dart';

class Section extends ConsumerWidget {
  final String title;
  final AsyncValue<dynamic> asyncData; // PagedResponse<Media>
  const Section({super.key, required this.title, required this.asyncData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 8),
        SizedBox(
          height: 260,
          child: asyncData.when(
            data: (paged) {
              final List<Media> items = paged.results;
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (ctx, i) {
                  final m = items[i];
                  return SizedBox(
                    width: 140,
                    child: PosterCard(
                      posterPath: m.posterPath,
                      title: m.title,
                      rating: m.rating,
                      onTap: () => context.go('/details/${m.id}?title=${Uri.encodeComponent(m.title)}'
                          '&poster=${Uri.encodeComponent(m.posterPath ?? '')}'
                          '&overview=${Uri.encodeComponent(m.overview ?? '')}'
                          '&rating=${m.rating}'
                          '&type=${m.type.name}'),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Error: $e'),
          ),
        ),
      ],
    );
  }
}
