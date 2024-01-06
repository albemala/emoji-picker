import 'package:flutter/foundation.dart';

enum GlyphType {
  emoji,
  symbol,
  kaomoji,
}

@immutable
class Glyph {
  final GlyphType type;
  final String glyph;
  final String unicode;
  final String htmlCode;
  final String name;
  final List<String> keywords;
  final String group;

  const Glyph({
    required this.type,
    required this.glyph,
    required this.unicode,
    required this.htmlCode,
    required this.name,
    required this.keywords,
    required this.group,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Glyph &&
          runtimeType == other.runtimeType &&
          glyph == other.glyph;

  @override
  int get hashCode => glyph.hashCode;
}
