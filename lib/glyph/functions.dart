import 'package:app/clipboard.dart';
import 'package:app/glyphs/defines/glyph.dart';
import 'package:app/routing.dart';
import 'package:app/widgets/snack-bar.dart';
import 'package:flutter/widgets.dart';

Future<void> copyGlyphToClipboard(
  BuildContext context,
  Glyph glyph,
) async {
  await copyToClipboard(glyph.glyph);
  showSnackBar(
    context,
    createCopiedToClipboardSnackBar(glyph.glyph),
  );
}

Future<void> copyGlyphUnicodeToClipboard(
  BuildContext context,
  Glyph glyph,
) async {
  await copyToClipboard(glyph.unicode);
  showSnackBar(
    context,
    createCopiedToClipboardSnackBar(glyph.unicode),
  );
}

Future<void> copyGlyphHtmlCodeToClipboard(
  BuildContext context,
  Glyph glyph,
) async {
  await copyToClipboard(glyph.htmlCode);
  showSnackBar(
    context,
    createCopiedToClipboardSnackBar(glyph.htmlCode),
  );
}
