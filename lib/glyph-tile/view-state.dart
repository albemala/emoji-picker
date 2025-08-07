import 'package:app/glyph-data/defines/glyph.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class GlyphTileViewState extends Equatable {
  final Glyph glyph;
  final bool isSelected;

  const GlyphTileViewState({required this.glyph, required this.isSelected});

  @override
  List<Object> get props => [glyph, isSelected];

  GlyphTileViewState copyWith({Glyph? glyph, bool? isSelected}) {
    return GlyphTileViewState(
      glyph: glyph ?? this.glyph,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

const defaultGlyphTileViewState = GlyphTileViewState(
  glyph: unknownGlyph,
  isSelected: false,
);
