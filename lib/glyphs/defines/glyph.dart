import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum GlyphType {
  emoji,
  symbol,
  kaomoji,
}

@immutable
class Glyph extends Equatable {
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
  List<Object> get props => [
        type,
        glyph,
        unicode,
        htmlCode,
        name,
        keywords,
        group,
      ];
}
