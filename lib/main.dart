import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/app_router.dart';
import 'app/app_theme.dart';
import 'data/repositories/watchlist_repository.dart';

final watchlistRepoProvider = Provider<WatchlistRepository>((ref) => WatchlistRepository());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  final container = ProviderContainer();
  final watchlist = container.read(watchlistRepoProvider);
  await watchlist.init();
  runApp(UncontrolledProviderScope(container: container, child: const CinematzeApp()));
}

class CinematzeApp extends StatelessWidget {
  const CinematzeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cinemaze',
        theme: appTheme, 
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
