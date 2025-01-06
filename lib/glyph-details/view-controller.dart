import 'dart:async';

import 'package:app/glyph-details/view-state.dart';
import 'package:app/glyph/functions.dart';
import 'package:app/glyphs/defines/glyph.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:cross_platform/cross_platform.dart' as cross_platform;
import 'package:flutter/services.dart';
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

  @override
  Future<void> close() async {
    await _selectedGlyphDataControllerSubscription?.cancel();
    await super.close();
  }
}

final copyGlyphShortcuts = {
  if (cross_platform.Platform.isMacOS) //
    LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyC):
        const CopyGlyphIntent(),
  if (cross_platform.Platform.isWindows || cross_platform.Platform.isLinux) //
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyC):
        const CopyGlyphIntent(),
};

class CopyGlyphIntent extends Intent {
  const CopyGlyphIntent();
}

class CopyGlyphAction extends Action<CopyGlyphIntent> {
  final BuildContext context;
  final Glyph glyph;

  CopyGlyphAction(
    this.context,
    this.glyph,
  );

  @override
  void invoke(covariant CopyGlyphIntent intent) {
    copyGlyphToClipboard(context, glyph);
  }
}
