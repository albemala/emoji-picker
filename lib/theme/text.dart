import 'package:app/glyph-data/defines/glyph.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getDisplayTextStyle(BuildContext context) {
  return GoogleFonts.titilliumWeb(
    textStyle: Theme.of(context).textTheme.displayMedium,
    fontWeight: FontWeight.w900,
  );
}

TextStyle getHeadlineTextStyle(BuildContext context) {
  return GoogleFonts.titilliumWeb(
    textStyle: Theme.of(context).textTheme.headlineSmall,
  );
}

TextStyle getTitleTextStyle(BuildContext context) {
  return GoogleFonts.titilliumWeb(
    textStyle: Theme.of(context).textTheme.titleMedium,
  );
}

TextStyle getSubtitleTextStyle(BuildContext context) {
  return GoogleFonts.titilliumWeb(
    textStyle: Theme.of(context).textTheme.labelMedium,
  );
}

TextStyle getBodyTextStyle(BuildContext context) {
  return GoogleFonts.titilliumWeb(
    textStyle: Theme.of(context).textTheme.bodyMedium,
  );
}

TextStyle getLabelTextStyle(BuildContext context) {
  return GoogleFonts.titilliumWeb(
    textStyle: Theme.of(context).textTheme.labelMedium,
  );
}

// ====== Button styles ======

TextStyle getLargeButtonTextStyle(BuildContext context) {
  return GoogleFonts.titilliumWeb(
    textStyle: Theme.of(context).textTheme.displayMedium,
    fontWeight: FontWeight.w700,
  );
}

TextStyle getNormalButtonTextStyle(BuildContext context) {
  return GoogleFonts.titilliumWeb(
    textStyle: Theme.of(context).textTheme.titleMedium,
  );
}

TextStyle getSmallButtonTextStyle(BuildContext context) {
  return GoogleFonts.titilliumWeb(
    textStyle: Theme.of(context).textTheme.bodyMedium,
  );
}

// ====== Glyph styles ======

TextStyle getTextStyleForGlyph(Glyph glyph) {
  switch (glyph.type) {
    case GlyphType.emoji:
      return TextStyle(
        fontFamilyFallback: [
          'Apple Color Emoji', // iOS and macOS
          'Segoe UI Emoji', // Windows
          'Android Emoji', // Android
          GoogleFonts.notoColorEmoji().fontFamily ?? '', // Web
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
