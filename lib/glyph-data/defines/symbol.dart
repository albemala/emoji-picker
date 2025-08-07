import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Symbol extends Equatable {
  final int charcode;
  final String name;
  final String group;

  const Symbol({
    required this.charcode,
    required this.name,
    required this.group,
  });

  @override
  List<Object> get props => [charcode, name, group];

  Map<String, dynamic> toMap() {
    return {'charcode': charcode, 'name': name, 'group': group};
  }

  factory Symbol.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        'charcode': final int charcode,
        'name': final String name,
        'group': final String group,
      } =>
        Symbol(charcode: charcode, name: name, group: group),
      _ => defaultSymbol,
    };
  }
}

const defaultSymbol = Symbol(charcode: 0, name: '', group: '');
