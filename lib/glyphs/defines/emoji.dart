import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Emoji extends Equatable {
  final String char;
  final String name;
  final String group;
  final bool skinToneSupport;
  final List<String> keywords;

  const Emoji({
    required this.char,
    required this.name,
    required this.group,
    required this.skinToneSupport,
    required this.keywords,
  });

  @override
  List<Object> get props => [
        char,
        name,
        group,
        skinToneSupport,
        keywords,
      ];

  Map<String, dynamic> toMap() {
    return {
      'char': char,
      'name': name,
      'group': group,
      'skinToneSupport': skinToneSupport,
      'keywords': keywords,
    };
  }

  factory Emoji.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        'char': final String char,
        'name': final String name,
        'group': final String group,
        'skinToneSupport': final bool skinToneSupport,
        'keywords': final List<String> keywords,
      } =>
        Emoji(
          char: char,
          name: name,
          group: group,
          skinToneSupport: skinToneSupport,
          keywords: keywords,
        ),
      _ => defaultEmoji,
    };
  }
}

const defaultEmoji = Emoji(
  char: '',
  name: '',
  group: '',
  skinToneSupport: false,
  keywords: [],
);
