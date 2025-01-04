import 'package:app/glyphs/defines/glyph.dart';
import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

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

String getGlyphHtmlCode(String glyph) {
  return '&#${glyph.runes.first.toRadixString(10).toUpperCase()};';
}

String getGlyphUnicode(String glyph) {
  return 'U+${glyph.runes.first.toRadixString(16).toUpperCase()}';
}

Map<String, List<Glyph>> glyphsByGroup(Iterable<Glyph> glyphs) {
  final map = <String, List<Glyph>>{};
  for (final glyph in glyphs) {
    map.update(
      glyph.group,
      ifAbsent: () => [glyph],
      (value) => value..add(glyph),
    );
  }
  return map;
}

bool matchesSearchTerm(Glyph glyph, String searchTerm) {
  return nameMatchesSearchTerm(glyph, searchTerm) ||
      keywordsMatchesSearchTerm(glyph, searchTerm);
}

bool nameMatchesSearchTerm(Glyph glyph, String searchTerm) {
  final lowerCaseName = glyph.name.toLowerCase();
  final lowerCaseSearchTerm = searchTerm.toLowerCase();
  final nameContainsSearchTerm = lowerCaseName.contains(lowerCaseSearchTerm);
  final nameMatchesSearchTerm = weightedRatio(glyph.name, searchTerm) > 80;
  return nameContainsSearchTerm || nameMatchesSearchTerm;
}

bool keywordsMatchesSearchTerm(Glyph glyph, String searchTerm) {
  final lowerCaseSearchTerm = searchTerm.toLowerCase();
  final keywordsContainsSearchTerm = glyph.keywords.any(
    (keyword) => keyword.toLowerCase().contains(lowerCaseSearchTerm),
  );
  final keywordsMatchesSearchTerm = glyph.keywords.any(
    (keyword) => weightedRatio(keyword, searchTerm) > 80,
  );
  return keywordsContainsSearchTerm || keywordsMatchesSearchTerm;
}
