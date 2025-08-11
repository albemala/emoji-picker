import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';

@immutable
class FavoritesDataState extends Equatable {
  final IList<String> favoriteGlyphs;

  const FavoritesDataState({
    required this.favoriteGlyphs,
  });

  @override
  List<Object> get props => [favoriteGlyphs];

  FavoritesDataState copyWith({
    IList<String>? favoriteGlyphs,
  }) {
    return FavoritesDataState(
      favoriteGlyphs: favoriteGlyphs ?? this.favoriteGlyphs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'favoriteGlyphs': favoriteGlyphs.toList(),
    };
  }

  factory FavoritesDataState.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        'favoriteGlyphs': final List<dynamic> favoriteGlyphs,
      } =>
        FavoritesDataState(
          favoriteGlyphs: favoriteGlyphs.cast<String>().toIList(),
        ),
      _ => defaultFavoritesDataState,
    };
  }
}

final defaultFavoritesDataState = FavoritesDataState(favoriteGlyphs: IList());
