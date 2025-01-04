import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Kaomoji extends Equatable {
  final String string;
  final List<String> keywords;

  const Kaomoji({
    required this.string,
    required this.keywords,
  });

  @override
  List<Object> get props => [string, keywords];

  Map<String, dynamic> toMap() {
    return {
      'string': string,
      'keywords': keywords,
    };
  }

  factory Kaomoji.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        'string': final String string,
        'keywords': final List<String> keywords,
      } =>
        Kaomoji(
          string: string,
          keywords: keywords,
        ),
      _ => defaultKaomoji,
    };
  }
}

const defaultKaomoji = Kaomoji(
  string: '',
  keywords: [],
);
