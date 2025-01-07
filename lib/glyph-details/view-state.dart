import 'package:app/glyph-data/defines/glyph.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class GlyphDetailsViewState extends Equatable {
  final Glyph glyph;

  const GlyphDetailsViewState({
    required this.glyph,
  });

  @override
  List<Object> get props => [
        glyph,
      ];
}

const defaultGlyphDetailsViewState = GlyphDetailsViewState(
  glyph: unknownGlyph,
);
