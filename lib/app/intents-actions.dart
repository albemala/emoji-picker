import 'package:app/glyph-details/view-controller.dart';
import 'package:app/search/data-controller.dart';
import 'package:cross_platform/cross_platform.dart' as cross_platform;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CopyGlyphIntent extends Intent {
  const CopyGlyphIntent();
}

class CopyGlyphAction extends Action<CopyGlyphIntent> {
  final BuildContext context;
  final GlyphDetailsViewController glyphDetailsViewController;

  CopyGlyphAction(this.context)
      : glyphDetailsViewController = context.read<GlyphDetailsViewController>();

  @override
  void invoke(covariant CopyGlyphIntent intent) {
    glyphDetailsViewController.copySelectedGlyphToClipboard(context);
    // ignore: invalid_use_of_visible_for_testing_member
    RawKeyboard.instance.clearKeysPressed();
  }
}

class FocusSearchIntent extends Intent {
  const FocusSearchIntent();
}

class FocusSearchAction extends Action<FocusSearchIntent> {
  final BuildContext context;
  final SearchGlyphsDataController searchGlyphsDataController;

  FocusSearchAction(this.context)
      : searchGlyphsDataController = context.read<SearchGlyphsDataController>();

  @override
  void invoke(covariant FocusSearchIntent intent) {
    searchGlyphsDataController.searchFocusNode.requestFocus();
    // ignore: invalid_use_of_visible_for_testing_member
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
