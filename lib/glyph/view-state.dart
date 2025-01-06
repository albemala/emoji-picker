import 'package:app/glyphs/defines/glyph.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class GlyphViewState extends Equatable {
  final Glyph glyph;

  const GlyphViewState({
    required this.glyph,
  });

  @override
  List<Object> get props => [
        glyph,
      ];
}

const defaultGlyphViewState = GlyphViewState(
  glyph: unknownGlyph,
);
