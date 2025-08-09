import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/widgets/ads.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class GlyphDetailsViewState extends Equatable {
  final Glyph glyph;
  final AdData adData;

  const GlyphDetailsViewState({required this.glyph, required this.adData});

  @override
  List<Object> get props => [glyph, adData];

  GlyphDetailsViewState copyWith({Glyph? glyph, AdData? adData}) {
    return GlyphDetailsViewState(
      glyph: glyph ?? this.glyph,
      adData: adData ?? this.adData,
    );
  }
}

final defaultGlyphDetailsViewState = GlyphDetailsViewState(
  glyph: unknownGlyph,
  adData: adsData.first,
);
