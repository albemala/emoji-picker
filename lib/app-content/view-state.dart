import 'package:app/glyphs/defines/glyph.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class AppContentViewState extends Equatable {
  final Glyph selectedGlyph;

  const AppContentViewState({
    required this.selectedGlyph,
  });

  @override
  List<Object> get props => [
        selectedGlyph,
      ];

  AppContentViewState copyWith({
    Glyph? selectedGlyph,
  }) {
    return AppContentViewState(
      selectedGlyph: selectedGlyph ?? this.selectedGlyph,
    );
  }
}

const defaultAppContentViewState = AppContentViewState(
  selectedGlyph: unknownGlyph,
);
