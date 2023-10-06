import 'dart:convert';

import 'package:app/extensions/string.dart';
import 'package:app/functions/glyphs.dart';
import 'package:app/models/emoji.dart';
import 'package:app/models/glyph.dart';
import 'package:app/models/kaomoji.dart';
import 'package:app/models/symbol.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_state_management/flutter_state_management.dart';

/// A class that loads and provides the glyphs (emoji, symbols).
class GlyphsConductor extends Conductor {
  factory GlyphsConductor.fromContext(BuildContext context) {
    return GlyphsConductor();
  }

  final emoji = ValueNotifier<Iterable<Glyph>>([]);
  final symbols = ValueNotifier<Iterable<Glyph>>([]);
  final kaomoji = ValueNotifier<Iterable<Glyph>>([]);

  GlyphsConductor() {
    _init();
  }

  Future<void> _init() async {
    emoji.value = await loadEmoji();
    symbols.value = await loadSymbols();
    kaomoji.value = await loadKaomoji();
  }

  @override
  void dispose() {
    emoji.dispose();
    symbols.dispose();
  }
}

@visibleForTesting
Future<Iterable<Glyph>> loadEmoji() async {
  final emojiDataFile = await rootBundle.loadString(
    'assets/data/emoji.json',
  );
  final emojiData = json.decode(emojiDataFile) as List<dynamic>;
  return emojiData
      .map(
    (item) => Emoji.fromJson(
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

@visibleForTesting
Future<Iterable<Glyph>> loadKaomoji() async {
  final kaomojiDataFile = await rootBundle.loadString(
    'assets/data/kaomoji.json',
  );
  final kaomojiData = json.decode(kaomojiDataFile) as List<dynamic>;
  return kaomojiData
      .map(
    (item) => Kaomoji.fromJson(
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
