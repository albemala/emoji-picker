import 'package:json_annotation/json_annotation.dart';

part 'emoji.g.dart';

@JsonSerializable()
class Emoji {
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

  factory Emoji.fromJson(Map<String, dynamic> json) => _$EmojiFromJson(json);

  Map<String, dynamic> toJson() => _$EmojiToJson(this);
}
