import 'dart:convert';

import 'package:app/extensions/string.dart';
import 'package:app/models/emoji.dart';
import 'package:app/models/glyph.dart';
import 'package:app/models/symbol.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_state_management/flutter_state_management.dart';

/// A class that loads and provides the glyphs (emojis, symbols).
class GlyphsConductor extends Conductor {
  factory GlyphsConductor.fromContext(BuildContext context) {
    return GlyphsConductor();
  }

  final emojis = ValueNotifier<Iterable<Glyph>>([]);
  final symbols = ValueNotifier<Iterable<Glyph>>([]);

  GlyphsConductor() {
    _init();
  }

  Future<void> _init() async {
    emojis.value = await loadEmojis();
    symbols.value = await loadSymbols();
  }

  @override
  void dispose() {
    emojis.dispose();
    symbols.dispose();
  }
}

@visibleForTesting
Future<Iterable<Glyph>> loadEmojis() async {
  final emojisDataFile = await rootBundle.loadString(
    'assets/data/emojis.json',
  );
  final emojisData = json.decode(emojisDataFile) as List<dynamic>;
  return emojisData
      .map(
        (item) => Emoji.fromJson(
          item as Map<String, dynamic>,
        ),
      )
      .map(
        (emoji) => Glyph(
          char: emoji.char,
          name: emoji.name.toFirstUpperCase(),
          keywords: emoji.keywords,
          group: emoji.group,
        ),
      );
}

@visibleForTesting
Future<Iterable<Glyph>> loadSymbols() async {
  final symbolsDataFile = await rootBundle.loadString(
    'assets/data/symbols.json',
  );
  final symbolsData = json.decode(symbolsDataFile) as List<dynamic>;
  return symbolsData
      .map(
        (item) => Symbol.fromJson(
          item as Map<String, dynamic>,
        ),
      )
      .map(
        (symbol) => Glyph(
          char: String.fromCharCode(symbol.charcode),
          name: symbol.name,
          keywords: [],
          group: symbol.group,
        ),
      );
}
