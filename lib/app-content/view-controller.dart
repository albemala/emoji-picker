import 'dart:async';

import 'package:app/app-content/view-state.dart';
import 'package:app/glyph-data/data-controller.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppContentViewController extends Cubit<AppContentViewState> {
  final GlyphsDataController glyphsDataController;
  final SelectedGlyphDataController selectedGlyphDataController;

  StreamSubscription<void>? glyphsDataControllerSubscription;

  factory AppContentViewController.fromContext(BuildContext context) {
    return AppContentViewController(
      context.read<GlyphsDataController>(),
      context.read<SelectedGlyphDataController>(),
    );
  }

  AppContentViewController(
    this.glyphsDataController,
    this.selectedGlyphDataController,
  ) : super(defaultAppContentViewState) {
    glyphsDataControllerSubscription = glyphsDataController.stream.listen((_) {
      _selectFirstEmojiIfAvailable();
    });
    _selectFirstEmojiIfAvailable();
  }

  @override
  Future<void> close() {
    glyphsDataControllerSubscription?.cancel();
    return super.close();
  }

  void _selectFirstEmojiIfAvailable() {
    if (glyphsDataController.state.emoji.isNotEmpty) {
      selectedGlyphDataController.selectedGlyph =
          glyphsDataController.state.emoji.first;
    }
  }
}
