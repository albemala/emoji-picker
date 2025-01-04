import 'package:app/glyphs/defines/glyph.dart';
import 'package:flutter/material.dart';

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
  }
}
