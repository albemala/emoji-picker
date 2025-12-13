import 'package:app/favorites/data-state.dart';
import 'package:app/glyph-data/defines/glyph.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data_storage/flutter_data_storage.dart';

class FavoritesDataController extends StoredCubit<FavoritesDataState> {
  factory FavoritesDataController.fromContext(BuildContext _) {
    return FavoritesDataController();
  }

  FavoritesDataController() : super(FavoritesDataState.initial());

  @override
  Future<void> migrateData() async {}

  @override
  String get storeName => 'favorites';

  @override
  FavoritesDataState fromMap(Map<String, dynamic> json) {
    return FavoritesDataState.fromMap(json);
  }

  @override
  Map<String, dynamic> toMap(FavoritesDataState state) {
    return state.toMap();
  }

  void toggleFavorite(Glyph glyph) {
    final newSet = state.favoriteGlyphs.contains(glyph.glyph)
        ? state.favoriteGlyphs.remove(glyph.glyph)
        : state.favoriteGlyphs.add(glyph.glyph);
    emit(state.copyWith(favoriteGlyphs: newSet));
  }

  bool isFavorite(Glyph glyph) => state.favoriteGlyphs.contains(glyph.glyph);

  void clearFavorites() {
    emit(state.copyWith(favoriteGlyphs: IList()));
  }
}
