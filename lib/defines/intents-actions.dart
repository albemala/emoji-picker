import 'package:app/conductors/glyph-actions-conductor.dart';
import 'package:app/conductors/search-glyphs-conductor.dart';
import 'package:cross_platform/cross_platform.dart' as cross_platform;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CopyGlyphIntent extends Intent {
  const CopyGlyphIntent();
}

class CopyGlyphAction extends Action<CopyGlyphIntent> {
  final GlyphActionsConductor glyphActionsConductor;

  CopyGlyphAction(this.glyphActionsConductor);

  @override
  void invoke(covariant CopyGlyphIntent intent) {
    glyphActionsConductor.copySelectedGlyphToClipboard();
    RawKeyboard.instance.clearKeysPressed();
  }
}

class FocusSearchIntent extends Intent {
  const FocusSearchIntent();
}

class FocusSearchAction extends Action<FocusSearchIntent> {
  final SearchGlyphsConductor searchGlyphsConductor;

  FocusSearchAction(this.searchGlyphsConductor);

  @override
  void invoke(covariant FocusSearchIntent intent) {
    searchGlyphsConductor.searchFocusNode.requestFocus();
    RawKeyboard.instance.clearKeysPressed();
  }
}

final shortcuts = {
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
