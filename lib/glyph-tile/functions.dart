import 'package:app/clipboard.dart';
import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/routing.dart';
import 'package:app/widgets/snack-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

TextStyle getTextStyleForGlyph(Glyph glyph) {
  switch (glyph.type) {
    case GlyphType.emoji:
      return const TextStyle(
        fontFamilyFallback: [
          'Apple Color Emoji', // iOS and macOS
          'Segoe UI Emoji', // Windows
          'Android Emoji', // Android
        ],
      );
    case GlyphType.symbol:
      return const TextStyle();
    case GlyphType.kaomoji:
      return const TextStyle();
    case GlyphType.unknown:
      return const TextStyle();
  }
}

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
