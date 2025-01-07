import 'dart:convert';
import 'dart:io';

import 'package:app/glyph-data/defines/emoji.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:http/http.dart' as http;

// Emoji data example:
// {
//   "😀": {
//     "name": "grinning face",
//     "slug": "grinning_face",
//     "group": "Smileys & Emotion",
//     "emoji_version": "1.0",
//     "unicode_version": "1.0",
//     "skin_tone_support": false
//   },
//   ...
// }
//
// Emoji keywords example:
// {
//   "😀": [
//     "grinning_face",
//     "face",
//     "smile",
//     "happy",
//     "joy",
//     ":D",
//     "grin"
//   ],
//   ...
// }

Emoji parseEmoji(
  MapEntry<String, dynamic> emojiEntry,
  Map<String, dynamic> emojiKeywords,
) {
  final char = emojiEntry.key;
  final emoji = emojiEntry.value as Map<String, dynamic>;
  final name = emoji['name'] as String;
  final group = emoji['group'] as String;
  final skinToneSupport = emoji['skin_tone_support'] as bool;
  final keywords = emojiKeywords[char] as List<dynamic>? ?? [];
  return Emoji(
    char: char,
    name: name,
    group: group,
    skinToneSupport: skinToneSupport,
    keywords: keywords.cast<String>().toIList(),
  );
}

Future<void> main() async {
  // source: https://github.com/muan/unicode-emoji-json
  const emojiDataUrl =
      'https://unpkg.com/unicode-emoji-json@0.5.0/data-by-emoji.json';
  // source: https://github.com/muan/emojilib
  const emojiKeywordsUrl =
      'https://unpkg.com/emojilib@3.0.7/dist/emoji-en-US.json';

  final emojiDataResponse = await http.get(Uri.parse(emojiDataUrl));
  final emojiData = //
      json.decode(emojiDataResponse.body) as Map<String, dynamic>;

  final emojiKeywordsResponse = await http.get(Uri.parse(emojiKeywordsUrl));
  final emojiKeywords = //
      json.decode(emojiKeywordsResponse.body) as Map<String, dynamic>;

  final emoji = emojiData.entries
      .map((entry) => parseEmoji(entry, emojiKeywords))
      .toList();

  File('assets/data/emoji.json') //
      .writeAsStringSync(json.encode(emoji));
}
