import 'dart:async';

import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyph-details/dialog.dart';
import 'package:app/glyph-tile/view-state.dart';
import 'package:app/responsive.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphTileViewController extends Cubit<GlyphTileViewState> {
  final SelectedGlyphDataController selectedGlyphDataController;

  StreamSubscription<void>? selectedGlyphDataControllerSubscription;

  final focusNode = FocusNode();

  factory GlyphTileViewController.fromContext(BuildContext context) {
    return GlyphTileViewController(context.read<SelectedGlyphDataController>());
  }

  GlyphTileViewController(this.selectedGlyphDataController)
    : super(defaultGlyphTileViewState) {
    selectedGlyphDataControllerSubscription = selectedGlyphDataController.stream
        .listen((_) {
          updateState();
        });
  }

  void setGlyph(Glyph glyph) {
    emit(state.copyWith(glyph: glyph));
  }

  @override
  Future<void> close() {
    focusNode.dispose();
    selectedGlyphDataControllerSubscription?.cancel();
    return super.close();
  }

  void updateState() {
    // if (selectedGlyphDataController.selectedGlyph == unknownGlyph) {
    //   focusNode.unfocus();
    // }
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
      // selectedGlyphDataController.selectedGlyph = unknownGlyph;
    }
  }

  Future<void> onTap(BuildContext context) async {
    focusNode.requestFocus();
    if (isMobileScreen(context)) {
      // On mobile, show full-screen dialog
      await showGlyphDetailsDialog(context);
      focusNode.unfocus();
    }
    // else {
    // On desktop, use existing focus behavior
    // focusNode.requestFocus();
    // }
  }
}
