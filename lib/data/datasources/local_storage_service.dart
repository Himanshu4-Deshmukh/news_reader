import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_reader/core/constants/app_constants.dart';

class LocalStorageService {
  late Box _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(AppConstants.hiveBoxName);
  }

  Future<void> save(String key, dynamic value) async {
    await _box.put(key, value);
  }

  dynamic get(String key, {dynamic defaultValue}) {
    return _box.get(key, defaultValue: defaultValue);
  }

  Future<void> remove(String key) async {
    await _box.delete(key);
  }

  Future<void> clear() async {
    await _box.clear();
  }

  List<dynamic> getList(String key) {
    final data = _box.get(key);
    if (data is List) return data;
    return [];
  }

  Future<void> saveList(String key, List<dynamic> list) async {
    await _box.put(key, list);
  }
}
