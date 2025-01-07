import 'dart:async';

import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyph-tile/view-state.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphTileViewController extends Cubit<GlyphTileViewState> {
  final SelectedGlyphDataController _selectedGlyphDataController;
  StreamSubscription<void>? _selectedGlyphDataControllerSubscription;

  final focusNode = FocusNode();

  factory GlyphTileViewController.fromContext(
    BuildContext context,
    Glyph glyph,
  ) {
    return GlyphTileViewController(
      glyph,
      context.read<SelectedGlyphDataController>(),
    );
  }

  GlyphTileViewController(
    Glyph glyph,
    this._selectedGlyphDataController,
  ) : super(defaultGlyphTileViewState) {
    emit(
      state.copyWith(
        glyph: glyph,
      ),
    );
    _selectedGlyphDataControllerSubscription =
        _selectedGlyphDataController.stream.listen((_) {
      _updateState();
    });
  }

  @override
  Future<void> close() {
    focusNode.dispose();
    _selectedGlyphDataControllerSubscription?.cancel();
    return super.close();
  }

  void _updateState() {
    if (_selectedGlyphDataController.selectedGlyph == unknownGlyph) {
      focusNode.unfocus();
    }
    emit(
      state.copyWith(
        isSelected: state.glyph == _selectedGlyphDataController.selectedGlyph,
      ),
    );
  }

  void onFocusChange(bool isFocused) {
    if (isFocused) {
      _selectedGlyphDataController.selectedGlyph = state.glyph;
    } else {
      _selectedGlyphDataController.selectedGlyph = unknownGlyph;
    }
  }

  void selectGlyph() {
    _selectedGlyphDataController.selectedGlyph = state.glyph;
  }
}
