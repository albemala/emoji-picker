import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/widgets/ads.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class GlyphDetailsViewState extends Equatable {
  final Glyph glyph;
  final AdData adData;
  final bool isFavorite;

  const GlyphDetailsViewState({
    required this.glyph,
    required this.adData,
    required this.isFavorite,
  });

  @override
  List<Object> get props => [glyph, adData, isFavorite];

  GlyphDetailsViewState copyWith({
    Glyph? glyph,
    AdData? adData,
    bool? isFavorite,
  }) {
    return GlyphDetailsViewState(
      glyph: glyph ?? this.glyph,
      adData: adData ?? this.adData,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

final defaultGlyphDetailsViewState = GlyphDetailsViewState(
  glyph: unknownGlyph,
  adData: adsData.first,
  isFavorite: false,
);
