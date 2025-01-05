import 'package:app/glyphs/defines/glyph.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class GlyphDetailsViewState extends Equatable {
  final Glyph selectedGlyph;
  final bool isGlyphDetailsVisible;

  const GlyphDetailsViewState({
    required this.selectedGlyph,
    required this.isGlyphDetailsVisible,
  });

  @override
  List<Object> get props => [
        selectedGlyph,
        isGlyphDetailsVisible,
      ];
}

const defaultGlyphDetailsViewState = GlyphDetailsViewState(
  selectedGlyph: unknownGlyph,
  isGlyphDetailsVisible: false,
);
