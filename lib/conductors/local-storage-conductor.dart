import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_management/flutter_state_management.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageConductor extends Conductor implements StorageConductor {
  factory LocalStorageConductor.fromContext(BuildContext context) {
    return LocalStorageConductor();
  }

  final isInitialized = ValueNotifier<bool>(false);

  LocalStorageConductor() {
    _init();
  }

  Future<void> _init() async {
    if (!kIsWeb) {
      final appSupportDirectory = await getApplicationSupportDirectory();
      if (kDebugMode) print(appSupportDirectory.path);
      Hive.init(appSupportDirectory.path);
    }
    isInitialized.value = true;
  }

  @override
  Future<void> dispose() async {
    isInitialized.dispose();
    await Hive.close();
  }

  @override
  Future<void> save(String storeName, Map<String, dynamic> map) async {
    await _waitForInitialization();
    final box = await _getBox(storeName);
    await box.put(storeName, map);
  }

  @override
  Future<Map<String, dynamic>> load(String storeName) async {
    await _waitForInitialization();
    final box = await _getBox(storeName);
    final map = box.get(storeName) ?? {};
    return Map<String, dynamic>.from(map);
  }

  Future<Box<Map<dynamic, dynamic>>> _getBox(String boxName) {
    return Hive.openBox<Map<dynamic, dynamic>>(boxName);
  }

  Future<void> _waitForInitialization() async {
    while (!isInitialized.value) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
    }
  }
}
