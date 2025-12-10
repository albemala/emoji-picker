import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/recent/data-state.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data_storage/flutter_data_storage.dart';

class RecentDataController extends StoredCubit<RecentDataState> {
  static const int maxRecentItems = 30;

  factory RecentDataController.fromContext(BuildContext context) {
    return RecentDataController();
  }

  RecentDataController() : super(RecentDataState.initial());

  @override
  Future<void> migrateData() async {}

  @override
  String get storeName => 'recent';

  @override
  RecentDataState fromMap(Map<String, dynamic> json) {
    return RecentDataState.fromMap(json);
  }

  @override
  Map<String, dynamic> toMap(RecentDataState state) {
    return state.toMap();
  }

  void addRecentGlyph(Glyph glyph) {
    final now = DateTime.now();
    final glyphString = glyph.glyph;

    // Remove existing entry if it exists
    final filteredList = state.recentGlyphs
        .where((entry) => entry.glyph != glyphString)
        .toList();

    // Add new entry at the beginning
    final newEntry = RecentGlyphEntry(glyph: glyphString, timestamp: now);
    final updatedList = [newEntry, ...filteredList];

    // Keep only the most recent items up to the limit
    final limitedList = updatedList.take(maxRecentItems).toList();

    emit(state.copyWith(recentGlyphs: limitedList.toIList()));
  }

  void clearRecentGlyphs() {
    emit(state.copyWith(recentGlyphs: IList()));
  }

  List<String> getRecentGlyphStrings() {
    return state.recentGlyphs.map((entry) => entry.glyph).toList();
  }
}
