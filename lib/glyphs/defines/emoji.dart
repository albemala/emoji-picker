import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';

@immutable
class Emoji extends Equatable {
  final String char;
  final String name;
  final String group;
  final bool skinToneSupport;
  final IList<String> keywords;

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
        'keywords': final List<dynamic> keywords,
      } =>
        Emoji(
          char: char,
          name: name,
          group: group,
          skinToneSupport: skinToneSupport,
          keywords: keywords.cast<String>().toIList(),
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
  keywords: IList.empty(),
);
