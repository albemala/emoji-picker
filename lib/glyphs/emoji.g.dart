// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emoji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Emoji _$EmojiFromJson(Map<String, dynamic> json) => Emoji(
      char: json['char'] as String,
      name: json['name'] as String,
      group: json['group'] as String,
      skinToneSupport: json['skinToneSupport'] as bool,
      keywords:
          (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$EmojiToJson(Emoji instance) => <String, dynamic>{
      'char': instance.char,
      'name': instance.name,
      'group': instance.group,
      'skinToneSupport': instance.skinToneSupport,
      'keywords': instance.keywords,
    };
