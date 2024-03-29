import 'dart:convert';

import 'package:app/glyphs/emoji/emoji.dart';
import 'package:app/glyphs/functions.dart';
import 'package:app/glyphs/glyph.dart';
import 'package:app/glyphs/kaomoji/kaomoji.dart';
import 'package:app/glyphs/string.dart';
import 'package:app/glyphs/symbol/symbol.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class GlyphsState extends Equatable {
  final Iterable<Glyph> emoji;
  final Iterable<Glyph> symbols;
  final Iterable<Glyph> kaomoji;

  const GlyphsState({
    required this.emoji,
    required this.symbols,
    required this.kaomoji,
  });

  @override
  List<Object?> get props => [
        emoji,
        symbols,
        kaomoji,
      ];
}

/// A class that loads and provides the glyphs (emoji, symbols).
class GlyphsBloc extends Cubit<GlyphsState> {
  factory GlyphsBloc.fromContext(BuildContext context) {
    return GlyphsBloc();
  }

  GlyphsBloc()
      : super(
          const GlyphsState(
            emoji: [],
            symbols: [],
            kaomoji: [],
          ),
        ) {
    _init();
  }

  Future<void> _init() async {
    await _updateState();
  }

  Future<void> _updateState() async {
    emit(
      GlyphsState(
        emoji: await loadEmoji(),
        symbols: await loadSymbols(),
        kaomoji: await loadKaomoji(),
      ),
    );
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
