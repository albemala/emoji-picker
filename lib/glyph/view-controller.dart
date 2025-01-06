import 'package:app/glyph/view-state.dart';
import 'package:app/glyphs/defines/glyph.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphViewController extends Cubit<GlyphViewState> {
  final SelectedGlyphDataController _selectedGlyphDataController;

  final focusNode = FocusNode();

  factory GlyphViewController.fromContext(
    BuildContext context,
    Glyph glyph,
  ) {
    return GlyphViewController(
      context.read<SelectedGlyphDataController>(),
      glyph,
    );
  }

  GlyphViewController(
    this._selectedGlyphDataController,
    Glyph glyph,
  ) : super(defaultGlyphViewState) {
    emit(
      GlyphViewState(
        glyph: glyph,
      ),
    );
  }

  @override
  Future<void> close() async {
    focusNode.dispose();
    await super.close();
  }

  void onFocusChange(bool isFocused) {
    if (isFocused) {
      _selectedGlyphDataController.selectedGlyph = state.glyph;
    } else {
      _selectedGlyphDataController.selectedGlyph = unknownGlyph;
    }
  }
}
