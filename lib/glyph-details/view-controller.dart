import 'dart:async';

import 'package:app/clipboard.dart';
import 'package:app/glyph-details/view-state.dart';
import 'package:app/routing.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:app/widgets/ads.dart';
import 'package:app/widgets/snack-bar.dart';
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
    final selectedGlyph = selectedGlyphDataController.state.selectedGlyph;
    final adData = selectRandomAdData(); // Always select an ad

    emit(
      GlyphDetailsViewState(
        glyph: selectedGlyph,
        adData: adData,
      ),
    );
  }

  Future<void> copyGlyphToClipboard(BuildContext context) async {
    final glyph = state.glyph;
    await copyToClipboard(glyph.glyph);
    showSnackBar(context, createCopiedToClipboardSnackBar(glyph.glyph));
  }
}
