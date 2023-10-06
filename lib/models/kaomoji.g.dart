// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kaomoji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kaomoji _$KaomojiFromJson(Map<String, dynamic> json) => Kaomoji(
      string: json['string'] as String,
      keywords:
          (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$KaomojiToJson(Kaomoji instance) => <String, dynamic>{
      'string': instance.string,
      'keywords': instance.keywords,
    };
