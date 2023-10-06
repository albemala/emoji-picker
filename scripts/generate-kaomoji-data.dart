import 'dart:convert';
import 'dart:io';

import 'package:app/models/kaomoji.dart';
import 'package:http/http.dart' as http;

// Kaomoji data example:
// {
//    "tags":[
//       "hide"
//    ],
//    "string":"(⊃‿⊂)"
// },
// {
//    "tags":[
//       "hide"
//    ],
//    "string":"|_・)"
// },
// {
//    "tags":[
//       "hide"
//    ],
//    "string":"|･ω･｀)"
// },

Kaomoji parseKaomoji(
  Map<String, dynamic> kaomojiAsMap,
) {
  final string = kaomojiAsMap['string'] as String? ?? '';
  final keywords = List<String>.from(
    kaomojiAsMap['tags'] as List<dynamic>? ?? [],
  );
  return Kaomoji(
    string: string,
    keywords: keywords,
  );
}

Future<void> main() async {
  // source: https://github.com/itsmeichigo/peachy/
  const kaomojiDataUrl =
      'https://raw.githubusercontent.com/itsmeichigo/peachy/main/Peachy/kaomoji.json';

  final kaomojiDataResponse = await http.get(Uri.parse(kaomojiDataUrl));
  final kaomojiData = //
      json.decode(kaomojiDataResponse.body) as List<dynamic>;

  final kaomoji = kaomojiData
      .map(
        (entry) => parseKaomoji(entry as Map<String, dynamic>),
      )
      .toList();

  File('assets/data/kaomoji.json') //
      .writeAsStringSync(json.encode(kaomoji));
}
