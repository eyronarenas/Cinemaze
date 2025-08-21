enum MediaType { movie, tv, person, unknown }

MediaType _parseType(String? s) {
  switch (s) {
    case 'movie': return MediaType.movie;
    case 'tv': return MediaType.tv;
    default: return MediaType.unknown;
  }
}

class Media {
  final int id;
  final MediaType type;
  final String title;       // movie.title or tv.name
  final String? overview;
  final String? posterPath; // relative path
  final double rating;      // vote_average (0..10)

  Media({
    required this.id,
    required this.type,
    required this.title,
    this.overview,
    this.posterPath,
    required this.rating,
  });

  factory Media.fromMap(Map<String, dynamic> m) {
    final type = _parseType(m['media_type'] as String?);
    final title = (m['title'] ?? m['name'] ?? '') as String;
    return Media(
      id: m['id'] as int,
      type: type,
      title: title,
      overview: m['overview'] as String?,
      posterPath: m['poster_path'] as String?,
      rating: (m['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
