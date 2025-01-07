import 'package:app/glyph-data/defines/glyph.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class GlyphTileViewState extends Equatable {
  final Glyph glyph;

  const GlyphTileViewState({
    required this.glyph,
  });

  @override
  List<Object> get props => [
        glyph,
      ];
}

const defaultGlyphTileViewState = GlyphTileViewState(
  glyph: unknownGlyph,
);
