import 'dart:convert';
import 'dart:io';

import 'package:app/glyph-data/defines/symbol.dart';
import 'package:collection/collection.dart';

// Unicode Block data examples:
// {begin: 0x0000, end: 0x007F, name: 'Basic Latin'},
// {begin: 0x0080, end: 0x00FF, name: 'Latin-1 Supplement'},
// {begin: 0x0100, end: 0x017F, name: 'Latin Extended-A'},
// {begin: 0x0180, end: 0x024F, name: 'Latin Extended-B'},
// {begin: 0x0250, end: 0x02AF, name: 'IPA Extensions'},

// Unicode Names data examples:
// "0x0020":"SPACE",
// "0x0021":"EXCLAMATION MARK",
// "0x0022":"QUOTATION MARK",
// "0x0023":"NUMBER SIGN",
// "0x0024":"DOLLAR SIGN",

// Unicode Names Extended data examples:
// 32 "Space"
// 33 "Exclamation Mark"
// 34 "Quotation Mark"
// 35 "Number Sign"
// 36 "Dollar Sign"

class Block {
  final int begin;
  final int end;
  final String name;

  const Block({
    required this.begin,
    required this.end,
    required this.name,
  });
}

class ExtendedName {
  final int charcode;
  final String name;

  const ExtendedName({
    required this.charcode,
    required this.name,
  });
}

Block? parseBlock(String line) {
  const regex = "begin: 0x([0-9A-F]+), end: 0x([0-9A-F]+), name: '(.*)'";
  final match = RegExp(regex).firstMatch(line);
  if (match == null) return null;

  final group1 = match.group(1);
  final group2 = match.group(2);
  final group3 = match.group(3);
  if (group1 == null || group2 == null || group3 == null) return null;

  final begin = int.tryParse(group1, radix: 16);
  final end = int.tryParse(group2, radix: 16);
  final name = group3;
  if (begin == null || end == null) return null;

  return Block(
    begin: begin,
    end: end,
    name: name,
  );
}

Block? findBlock(int charcode, List<Block> blocks) {
  for (final block in blocks) {
    if (charcode >= block.begin && charcode <= block.end) {
      return block;
    }
  }
  return null;
}

ExtendedName? parseExtendedName(String line) {
  const regex = '([0-9]+) "(.*)"';
  final match = RegExp(regex).firstMatch(line);
  if (match == null) return null;

  final group1 = match.group(1);
  final group2 = match.group(2);
  if (group1 == null || group2 == null) return null;

  final charcode = int.tryParse(group1);
  final name = group2;
  if (charcode == null) return null;

  return ExtendedName(
    charcode: charcode,
    name: name,
  );
}

Symbol? parseSymbol(
  String line,
  List<Block> blocks,
  Map<int, String> extendedNames,
) {
  const regex = '"0x([0-9A-F]+)":"(.*)"';
  final match = RegExp(regex).firstMatch(line);
  if (match == null) return null;

  final group1 = match.group(1);
  final group2 = match.group(2);
  if (group1 == null || group2 == null) return null;

  final charcode = int.tryParse(group1, radix: 16);
  final name = extendedNames[charcode] ?? group2;
  if (charcode == null) return null;

  final block = findBlock(charcode, blocks);
  if (block == null) return null;

  return Symbol(
    charcode: charcode,
    name: name,
    group: block.name,
  );
}

void main() {
  // load unicode-blocks.txt file
  // source: https://raw.githubusercontent.com/glyphr-studio/Glyphr-Studio-1/master/dev/js/lib_unicode_blocks.js
  final unicodeBlocksFile = File('scripts/data/unicode-blocks.txt');
  final blocks = unicodeBlocksFile
      .readAsLinesSync()
      .map(parseBlock)
      .whereNotNull()
      .toList();

  // load unicode-names-extended.txt
  // source: https://raw.githubusercontent.com/reactos/reactos/master/dll/win32/getuname/lang/en-US.rc
  final unicodeNamesExtendedFile =
      File('scripts/data/unicode-names-extended.txt');
  final extendedNames = unicodeNamesExtendedFile
      .readAsLinesSync()
      .map(parseExtendedName)
      .whereNotNull();
  final extendedNamesMap = {
    for (final item in extendedNames) //
      item.charcode: item.name,
  };

  // load unicode-names.txt file
  // source: https://raw.githubusercontent.com/glyphr-studio/Glyphr-Studio-1/master/dev/js/lib_unicode_names.js
  final unicodeNamesFile = File('scripts/data/unicode-names.txt');
  final symbols = unicodeNamesFile
      .readAsLinesSync()
      .map((line) => parseSymbol(line, blocks, extendedNamesMap))
      .whereNotNull()
      .toList();

  // write symbols to assets/data/symbols2.json
  File('assets/data/symbols.json') //
      .writeAsStringSync(json.encode(symbols));
}
