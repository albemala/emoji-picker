import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStoreDataController extends Cubit<void> {
  factory LocalStoreDataController.fromContext(BuildContext context) {
    return LocalStoreDataController();
  }

  LocalStoreDataController() : super(null);

  Future<void> save(String storeName, Map<String, dynamic> map) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = map.toString();
    await prefs.setString(storeName, jsonString);
  }

  Future<Map<String, dynamic>> load(String storeName) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(storeName) ?? '{}';
    final map = json.decode(jsonString) as Map<dynamic, dynamic>;
    return Map<String, dynamic>.from(map);
  }
}
