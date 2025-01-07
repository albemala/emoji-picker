import 'dart:convert';

import 'package:app/glyph-data/defines/emoji.dart';
import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyph-data/defines/kaomoji.dart';
import 'package:app/glyph-data/defines/symbol.dart';
import 'package:app/string.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/services.dart';

Future<List<Glyph>> loadEmoji() async {
  final emojiDataFile = await rootBundle.loadString(
    'assets/data/emoji.json',
  );
  final emojiData = json.decode(emojiDataFile) as List<dynamic>;
  return emojiData //
      .cast<Map<String, dynamic>>()
      .map(Emoji.fromMap)
      .map(
    (emoji) {
      final glyph = emoji.char;
      return Glyph(
        type: GlyphType.emoji,
        glyph: glyph,
        unicode: getGlyphUnicode(glyph),
        htmlCode: getGlyphHtmlCode(glyph),
        name: emoji.name.toFirstUpperCase(),
        keywords: emoji.keywords,
        group: emoji.group,
      );
    },
  ).toList();
}

Future<List<Glyph>> loadSymbols() async {
  final symbolsDataFile = await rootBundle.loadString(
    'assets/data/symbols.json',
  );
  final symbolsData = json.decode(symbolsDataFile) as List<dynamic>;
  return symbolsData //
      .cast<Map<String, dynamic>>()
      .map(Symbol.fromMap)
      .map(
    (symbol) {
      final glyph = String.fromCharCode(symbol.charcode);
      return Glyph(
        type: GlyphType.symbol,
        glyph: glyph,
        unicode: getGlyphUnicode(glyph),
        htmlCode: getGlyphHtmlCode(glyph),
        name: symbol.name,
        keywords: const IList.empty(),
        group: symbol.group,
      );
    },
  ).toList();
}

Future<List<Glyph>> loadKaomoji() async {
  final kaomojiDataFile = await rootBundle.loadString(
    'assets/data/kaomoji.json',
  );
  final kaomojiData = json.decode(kaomojiDataFile) as List<dynamic>;
  return kaomojiData //
      .cast<Map<String, dynamic>>()
      .map(Kaomoji.fromMap)
      .map(
    (kaomoji) {
      final glyph = kaomoji.string;
      return Glyph(
        type: GlyphType.kaomoji,
        glyph: glyph,
        unicode: '',
        htmlCode: '',
        name: kaomoji.keywords.first.toFirstUpperCase(),
        keywords: kaomoji.keywords,
        // group: '',
        group: kaomoji.keywords.first,
      );
    },
  ).toList();
}

String getGlyphHtmlCode(String glyph) {
  return '&#${glyph.runes.first.toRadixString(10).toUpperCase()};';
}

String getGlyphUnicode(String glyph) {
  return 'U+${glyph.runes.first.toRadixString(16).toUpperCase()}';
}
