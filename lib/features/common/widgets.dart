import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/env.dart';

String posterUrl(String? path, {String size = 'w500'}) {
  if (path == null) return '';
  return '${Env.tmdbImgBase}/$size$path';
}

class PosterCard extends StatelessWidget {
  final String? posterPath;
  final String title;
  final double rating;
  final VoidCallback onTap;
  const PosterCard({super.key, required this.posterPath, required this.title, required this.rating, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 2/3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: posterUrl(posterPath),
                fit: BoxFit.cover,
                placeholder: (_, __) => const ColoredBox(color: Color(0xFF1A1A22)),
                errorWidget: (_, __, ___) => const ColoredBox(color: Color(0xFF1A1A22)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600)),
          Row(children: [
            const Icon(Icons.star, size: 14),
            const SizedBox(width: 4),
            Text(rating.toStringAsFixed(1)),
          ]),
        ],
      ),
    );
  }
}
