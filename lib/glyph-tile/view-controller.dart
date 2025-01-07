import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyph-tile/view-state.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphTileViewController extends Cubit<GlyphTileViewState> {
  final SelectedGlyphDataController _selectedGlyphDataController;

  final focusNode = FocusNode();

  factory GlyphTileViewController.fromContext(
    BuildContext context,
    Glyph glyph,
  ) {
    return GlyphTileViewController(
      context.read<SelectedGlyphDataController>(),
      glyph,
    );
  }

  GlyphTileViewController(
    this._selectedGlyphDataController,
    Glyph glyph,
  ) : super(defaultGlyphTileViewState) {
    emit(
      GlyphTileViewState(
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
