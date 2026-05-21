import 'dart:async';

import 'package:emoji_picker/glyph-data/defines/glyph.dart';
import 'package:emoji_picker/glyph-tile/functions.dart';
import 'package:emoji_picker/search/data-controller.dart';
import 'package:emoji_picker/selected-glyph/data-controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_platform/universal_platform.dart';

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
      unawaited(copyGlyphToClipboard(context, selectedGlyph));
    }
  }
}

// ------ Shortcuts ------

final Map<LogicalKeySet, Intent> shortcuts = {
  // focus search
  if (UniversalPlatform.isMacOS) //
    LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyF):
        const FocusSearchIntent(),
  if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) //
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyF):
        const FocusSearchIntent(),
  LogicalKeySet(LogicalKeyboardKey.escape): const FocusSearchIntent(),
  // copy glyph
  if (UniversalPlatform.isMacOS) //
    LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyC):
        const CopyGlyphIntent(),
  if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) //
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyC):
        const CopyGlyphIntent(),
};
