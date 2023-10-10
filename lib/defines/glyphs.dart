import 'package:app/models/glyph.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getTextStyleForGlyph(Glyph glyph) {
  switch (glyph.type) {
    case GlyphType.emoji:
      return GoogleFonts.notoColorEmoji();
    case GlyphType.symbol:
      return const TextStyle();
    case GlyphType.kaomoji:
      return const TextStyle();
  }
}
