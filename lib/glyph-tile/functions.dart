import 'package:app/clipboard.dart';
import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/routing.dart';
import 'package:app/widgets/snack-bar.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getTextStyleForGlyph(Glyph glyph) {
  switch (glyph.type) {
    case GlyphType.emoji:
      return TextStyle(
        fontFamily: GoogleFonts.notoColorEmoji().fontFamily,
        fontFamilyFallback: [
          // 'Apple Color Emoji', // iOS and macOS
          // 'Segoe UI Emoji', // Windows
          // 'Android Emoji', // Android
        ],
      );
    case GlyphType.symbol:
      return const TextStyle(
        fontFamily: 'Noto Sans Living',
        fontFamilyFallback: [
          'Noto Sans Japanese',
          'Noto Sans Korean',
          'Noto Sans Simplified Chinese',
        ],
      );
    case GlyphType.kaomoji:
      return const TextStyle(
        fontFamily: 'Noto Sans Living',
        fontFamilyFallback: [
          'Noto Sans Japanese',
          'Noto Sans Korean',
          'Noto Sans Simplified Chinese',
        ],
      );
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
