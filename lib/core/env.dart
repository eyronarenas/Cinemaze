import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get tmdbKey => dotenv.env['TMDB_API_KEY'] ?? '';
  static String get tmdbBase => dotenv.env['TMDB_BASE_URL'] ?? 'https://api.themoviedb.org/3';
  static String get tmdbImgBase => dotenv.env['TMDB_IMG_BASE'] ?? 'https://image.tmdb.org/t/p';
}
