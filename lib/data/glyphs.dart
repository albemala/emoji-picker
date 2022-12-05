import 'dart:convert';

import 'package:app/extensions/string.dart';
import 'package:app/models/emoji/emoji.dart';
import 'package:app/models/symbol/symbol.dart';
import 'package:flutter/services.dart';

class Glyph {
  final String char;
  final String name;
  final List<String> keywords;
  final String group;

  const Glyph({
    required this.char,
    required this.name,
    required this.keywords,
    required this.group,
  });
}

List<Glyph> glyphs = [];

Future<void> loadGlyphs() async {
  await _loadEmojis();
  await _loadSymbols();
}

Future<void> _loadEmojis() async {
  final emojisDataFile = await rootBundle.loadString('assets/data/emojis.json');
  final emojisData = json.decode(emojisDataFile) as List<dynamic>;
  final emojis = emojisData
      .map((item) => Emoji.fromJson(item as Map<String, dynamic>))
      .toList();
  glyphs.addAll(
    emojis.map(
      (emoji) => Glyph(
        char: emoji.char,
        name: emoji.name.toFirstUpperCase(),
        keywords: emoji.keywords,
        group: emoji.group,
      ),
    ),
  );
}

Future<void> _loadSymbols() async {
  final symbolsDataFile =
      await rootBundle.loadString('assets/data/symbols.json');
  final symbolsData = json.decode(symbolsDataFile) as List<dynamic>;
  final symbols = symbolsData
      .map((item) => Symbol.fromJson(item as Map<String, dynamic>))
      .toList();
  glyphs.addAll(
    symbols.map(
      (symbol) => Glyph(
        char: String.fromCharCode(symbol.charcode),
        name: symbol.name,
        keywords: [],
        group: symbol.group,
      ),
    ),
  );
}

Map<String, List<Glyph>> glyphsByGroup(List<Glyph> glyphs) {
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
