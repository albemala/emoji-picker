import 'package:json_annotation/json_annotation.dart';

part 'kaomoji.g.dart';

@JsonSerializable()
class Kaomoji {
  final String string;
  final List<String> keywords;

  const Kaomoji({
    required this.string,
    required this.keywords,
  });

  factory Kaomoji.fromJson(Map<String, dynamic> json) =>
      _$KaomojiFromJson(json);

  Map<String, dynamic> toJson() => _$KaomojiToJson(this);
}
