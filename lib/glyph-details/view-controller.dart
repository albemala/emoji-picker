import 'dart:async';

import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyph-details/view-state.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphDetailsViewController extends Cubit<GlyphDetailsViewState> {
  final SelectedGlyphDataController _selectedGlyphDataController;
  StreamSubscription<void>? _selectedGlyphDataControllerSubscription;

  factory GlyphDetailsViewController.fromContext(BuildContext context) {
    return GlyphDetailsViewController(
      context.read<SelectedGlyphDataController>(),
    );
  }

  GlyphDetailsViewController(
    this._selectedGlyphDataController,
  ) : super(defaultGlyphDetailsViewState) {
    _selectedGlyphDataControllerSubscription =
        _selectedGlyphDataController.stream.listen((_) {
      _updateState();
    });
    _updateState();
  }

  @override
  Future<void> close() {
    _selectedGlyphDataControllerSubscription?.cancel();
    return super.close();
  }

  void _updateState() {
    emit(
      GlyphDetailsViewState(
        glyph: _selectedGlyphDataController.state.selectedGlyph,
      ),
    );
  }

  void closeDetailsView() {
    _selectedGlyphDataController.selectedGlyph = unknownGlyph;
  }
}
