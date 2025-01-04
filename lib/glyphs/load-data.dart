import 'dart:convert';

import 'package:app/glyphs/defines/emoji.dart';
import 'package:app/glyphs/defines/glyph.dart';
import 'package:app/glyphs/defines/kaomoji.dart';
import 'package:app/glyphs/defines/symbol.dart';
import 'package:app/glyphs/functions.dart';
import 'package:app/string.dart';
import 'package:flutter/services.dart';

Future<Iterable<Glyph>> loadEmoji() async {
  final emojiDataFile = await rootBundle.loadString(
    'assets/data/emoji.json',
  );
  final emojiData = json.decode(emojiDataFile) as List<dynamic>;
  return emojiData
      .map(
    (item) => Emoji.fromMap(
      item as Map<String, dynamic>,
    ),
  )
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
  );
}

Future<Iterable<Glyph>> loadSymbols() async {
  final symbolsDataFile = await rootBundle.loadString(
    'assets/data/symbols.json',
  );
  final symbolsData = json.decode(symbolsDataFile) as List<dynamic>;
  return symbolsData
      .map(
    (item) => Symbol.fromMap(
      item as Map<String, dynamic>,
    ),
  )
      .map(
    (symbol) {
      final glyph = String.fromCharCode(symbol.charcode);
      return Glyph(
        type: GlyphType.symbol,
        glyph: glyph,
        unicode: getGlyphUnicode(glyph),
        htmlCode: getGlyphHtmlCode(glyph),
        name: symbol.name,
        keywords: const [],
        group: symbol.group,
      );
    },
  );
}

Future<Iterable<Glyph>> loadKaomoji() async {
  final kaomojiDataFile = await rootBundle.loadString(
    'assets/data/kaomoji.json',
  );
  final kaomojiData = json.decode(kaomojiDataFile) as List<dynamic>;
  return kaomojiData
      .map(
    (item) => Kaomoji.fromMap(
      item as Map<String, dynamic>,
    ),
  )
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
  );
}
