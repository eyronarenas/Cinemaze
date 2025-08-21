import 'package:hive_flutter/hive_flutter.dart';

class WatchlistRepository {
  static const _boxName = 'watchlist';
  late final Box _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  List<int> getIds() => (_box.get('ids', defaultValue: <int>[]) as List).cast<int>();

  Future<void> toggle(int id) async {
    final ids = getIds();
    if (ids.contains(id)) {
      ids.remove(id);
    } else {
      ids.add(id);
    }
    await _box.put('ids', ids);
  }

  bool contains(int id) => getIds().contains(id);
}
