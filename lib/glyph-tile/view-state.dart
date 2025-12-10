import 'package:app/glyph-data/defines/glyph.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class GlyphTileViewState extends Equatable {
  final Glyph glyph;
  final bool isSelected;
  final bool isFocused;

  const GlyphTileViewState({
    required this.glyph,
    required this.isSelected,
    required this.isFocused,
  });

  factory GlyphTileViewState.initial() {
    return const GlyphTileViewState(
      glyph: unknownGlyph,
      isSelected: false,
      isFocused: false,
    );
  }

  @override
  List<Object> get props => [glyph, isSelected, isFocused];

  GlyphTileViewState copyWith({
    Glyph? glyph,
    bool? isSelected,
    bool? isFocused,
  }) {
    return GlyphTileViewState(
      glyph: glyph ?? this.glyph,
      isSelected: isSelected ?? this.isSelected,
      isFocused: isFocused ?? this.isFocused,
    );
  }
}
