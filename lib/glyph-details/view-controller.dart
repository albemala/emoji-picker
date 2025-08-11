import 'dart:async';

import 'package:app/clipboard.dart';
import 'package:app/favorites/data-controller.dart';
import 'package:app/glyph-details/view-state.dart';
import 'package:app/routing.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:app/widgets/ads.dart';
import 'package:app/widgets/snack-bar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphDetailsViewController extends Cubit<GlyphDetailsViewState> {
  final SelectedGlyphDataController selectedGlyphDataController;
  final FavoritesDataController favoritesDataController;

  StreamSubscription<void>? selectedGlyphDataControllerSubscription;
  StreamSubscription<void>? favoritesDataControllerSubscription;

  factory GlyphDetailsViewController.fromContext(BuildContext context) {
    return GlyphDetailsViewController(
      context.read<SelectedGlyphDataController>(),
      context.read<FavoritesDataController>(),
    );
  }

  GlyphDetailsViewController(
    this.selectedGlyphDataController,
    this.favoritesDataController,
  ) : super(defaultGlyphDetailsViewState) {
    selectedGlyphDataControllerSubscription = selectedGlyphDataController.stream
        .listen((_) {
          updateState();
        });
    favoritesDataControllerSubscription = favoritesDataController.stream.listen(
      (_) {
        updateState();
      },
    );
    updateState();
  }

  @override
  Future<void> close() {
    selectedGlyphDataControllerSubscription?.cancel();
    favoritesDataControllerSubscription?.cancel();
    return super.close();
  }

  void updateState() {
    final selectedGlyph = selectedGlyphDataController.state.selectedGlyph;
    final adData = selectRandomAdData(); // Always select an ad
    final isFavorite = favoritesDataController.isFavorite(selectedGlyph);
    emit(
      GlyphDetailsViewState(
        glyph: selectedGlyph,
        adData: adData,
        isFavorite: isFavorite,
      ),
    );
  }

  void toggleFavorite() {
    favoritesDataController.toggleFavorite(state.glyph);
  }

  Future<void> copyGlyphToClipboard(BuildContext context) async {
    final glyph = state.glyph;
    await copyToClipboard(glyph.glyph);
    showSnackBar(context, createCopiedToClipboardSnackBar(glyph.glyph));
  }
}
