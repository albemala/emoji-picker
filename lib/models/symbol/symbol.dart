import 'package:json_annotation/json_annotation.dart';

part 'symbol.g.dart';

@JsonSerializable()
class Symbol {
  final int charcode;
  final String name;
  final String group;

  const Symbol({
    required this.charcode,
    required this.name,
    required this.group,
  });

  factory Symbol.fromJson(Map<String, dynamic> json) => _$SymbolFromJson(json);

  Map<String, dynamic> toJson() => _$SymbolToJson(this);
}
