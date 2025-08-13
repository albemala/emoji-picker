import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyph-tile/functions.dart';
import 'package:app/search/data-controller.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:cross_platform/cross_platform.dart' as cross_platform;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ------ Intents ------

class FocusSearchIntent extends Intent {
  const FocusSearchIntent();
}

class CopyGlyphIntent extends Intent {
  const CopyGlyphIntent();
}

// ------ Actions ------

class FocusSearchAction extends Action<FocusSearchIntent> {
  final BuildContext context;

  FocusSearchAction(this.context);

  @override
  void invoke(FocusSearchIntent intent) {
    context.read<SearchGlyphsDataController>().focusNode.requestFocus();
  }
}

class CopyGlyphAction extends Action<CopyGlyphIntent> {
  final BuildContext context;

  CopyGlyphAction(this.context);

  @override
  void invoke(CopyGlyphIntent intent) {
    final controller = context.read<SelectedGlyphDataController>();
    final selectedGlyph = controller.state.selectedGlyph;
    if (selectedGlyph != unknownGlyph) {
      copyGlyphToClipboard(context, selectedGlyph);
    }
  }
}

// ------ Shortcuts ------

final Map<LogicalKeySet, Intent> shortcuts = {
  // focus search
  if (cross_platform.Platform.isMacOS) //
    LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyF):
        const FocusSearchIntent(),
  if (cross_platform.Platform.isWindows || cross_platform.Platform.isLinux) //
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyF):
        const FocusSearchIntent(),
  LogicalKeySet(LogicalKeyboardKey.escape): const FocusSearchIntent(),
  // copy glyph
  if (cross_platform.Platform.isMacOS) //
    LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyC):
        const CopyGlyphIntent(),
  if (cross_platform.Platform.isWindows || cross_platform.Platform.isLinux) //
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyC):
        const CopyGlyphIntent(),
};
