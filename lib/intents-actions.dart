import 'package:app/functions/clipboard.dart';
import 'package:flutter/widgets.dart';

class CopyGlyphIntent extends Intent {
  const CopyGlyphIntent();
}

class CopyGlyphAction extends Action<CopyGlyphIntent> {
  final BuildContext context;
  final String char;

  CopyGlyphAction(this.context, this.char);

  @override
  void invoke(covariant CopyGlyphIntent intent) =>
      copyToClipboard(context, char);
}

void copyGlyph(BuildContext context, String char) {
  CopyGlyphAction(context, char).invoke(const CopyGlyphIntent());
}

class FocusSearchIntent extends Intent {
  const FocusSearchIntent();
}

class FocusSearchAction extends Action<FocusSearchIntent> {
  final FocusNode? focusNode;

  FocusSearchAction(this.focusNode);

  @override
  void invoke(covariant FocusSearchIntent intent) => focusNode?.requestFocus();
}
