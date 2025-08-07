import 'dart:async';

import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyph-details/view-state.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphDetailsViewController extends Cubit<GlyphDetailsViewState> {
  final SelectedGlyphDataController selectedGlyphDataController;
  StreamSubscription<void>? selectedGlyphDataControllerSubscription;

  factory GlyphDetailsViewController.fromContext(BuildContext context) {
    return GlyphDetailsViewController(
      context.read<SelectedGlyphDataController>(),
    );
  }

  GlyphDetailsViewController(this.selectedGlyphDataController)
    : super(defaultGlyphDetailsViewState) {
    selectedGlyphDataControllerSubscription = selectedGlyphDataController.stream
        .listen((_) {
          updateState();
        });
    updateState();
  }

  @override
  Future<void> close() {
    selectedGlyphDataControllerSubscription?.cancel();
    return super.close();
  }

  void updateState() {
    emit(
      GlyphDetailsViewState(
        glyph: selectedGlyphDataController.state.selectedGlyph,
      ),
    );
  }

  void closeDetailsView() {
    selectedGlyphDataController.selectedGlyph = unknownGlyph;
  }
}
