import 'dart:async';

import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyph-tile/view-state.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphTileViewController extends Cubit<GlyphTileViewState> {
  final SelectedGlyphDataController selectedGlyphDataController;
  StreamSubscription<void>? selectedGlyphDataControllerSubscription;

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
    this.selectedGlyphDataController,
  ) : super(defaultGlyphTileViewState) {
    emit(
      state.copyWith(
        glyph: glyph,
      ),
    );
    selectedGlyphDataControllerSubscription =
        selectedGlyphDataController.stream.listen((_) {
      updateState();
    });
  }

  @override
  Future<void> close() {
    focusNode.dispose();
    selectedGlyphDataControllerSubscription?.cancel();
    return super.close();
  }

  void updateState() {
    if (selectedGlyphDataController.selectedGlyph == unknownGlyph) {
      focusNode.unfocus();
    }
    emit(
      state.copyWith(
        isSelected: state.glyph == selectedGlyphDataController.selectedGlyph,
      ),
    );
  }

  void onFocusChange(bool isFocused) {
    if (isFocused) {
      selectedGlyphDataController.selectedGlyph = state.glyph;
    } else {
      selectedGlyphDataController.selectedGlyph = unknownGlyph;
    }
  }

  void selectGlyph() {
    selectedGlyphDataController.selectedGlyph = state.glyph;
  }
}
