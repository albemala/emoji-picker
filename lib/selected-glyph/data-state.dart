import 'package:app/glyph-data/defines/glyph.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class SelectedGlyphDataState extends Equatable {
  final Glyph selectedGlyph;

  const SelectedGlyphDataState({
    required this.selectedGlyph,
  });

  @override
  List<Object> get props => [
        selectedGlyph,
      ];

  SelectedGlyphDataState copyWith({
    Glyph? selectedGlyph,
  }) {
    return SelectedGlyphDataState(
      selectedGlyph: selectedGlyph ?? this.selectedGlyph,
    );
  }
}

const defaultSelectedGlyphDataState = SelectedGlyphDataState(
  selectedGlyph: unknownGlyph,
);
