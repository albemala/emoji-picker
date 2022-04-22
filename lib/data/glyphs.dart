import 'dart:convert';

import 'package:emojis/emoji.dart';
import 'package:flutter/services.dart';

class GlyphGroup {
  final String name;

  const GlyphGroup({
    required this.name,
  });
}

class Glyph {
  final String char;
  final String name;
  final GlyphGroup group;

  const Glyph({
    required this.char,
    required this.name,
    required this.group,
  });
}

String getEmojiGroupName(EmojiGroup group) {
  switch (group) {
    case EmojiGroup.smileysEmotion:
      return 'Smileys & Emotion';
    case EmojiGroup.activities:
      return 'Activities';
    case EmojiGroup.peopleBody:
      return 'People & Body';
    case EmojiGroup.objects:
      return 'Objects';
    case EmojiGroup.travelPlaces:
      return 'Travel & Places';
    case EmojiGroup.component:
      return 'Component';
    case EmojiGroup.animalsNature:
      return 'Animals & Nature';
    case EmojiGroup.foodDrink:
      return 'Food & Drink';
    case EmojiGroup.symbols:
      return 'Symbols';
    case EmojiGroup.flags:
      return 'Flags';
  }
}

List<Glyph> glyphs = [];

Future<void> loadGlyphs() async {
  _loadEmojis();
  await _loadSymbols();
}

void _loadEmojis() {
  glyphs.addAll(
    Emoji.all()
        // Remove skin tones
        .where((element) => !element.modifiable)
        .map((emoji) {
      return Glyph(
        char: emoji.char,
        name: emoji.name,
        group: GlyphGroup(
          name: getEmojiGroupName(emoji.emojiGroup),
        ),
      );
    }),
  );
}

Future<void> _loadSymbols() async {
  final source = await rootBundle.loadString('assets/data/symbols.json');
  final decodedSource = json.decode(source) as List<dynamic>;
  final loadedGlyphs = decodedSource //
      .map(
    (dynamic symbol) => Glyph(
      char: symbol['char'] as String? ?? '',
      name: symbol['name'] as String? ?? '',
      group: GlyphGroup(
        name: symbol['group'] as String? ?? '',
      ),
    ),
  );
  glyphs.addAll(loadedGlyphs);
}

Map<String, List<Glyph>> glyphsByGroup(List<Glyph> glyphs) {
  final map = <String, List<Glyph>>{};
  for (final glyph in glyphs) {
    if (map.containsKey(glyph.group.name)) {
      map[glyph.group.name]?.add(glyph);
    } else {
      map[glyph.group.name] = [glyph];
    }
  }
  return map;
}
