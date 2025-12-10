import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class PurchasesDataState extends Equatable {
  final bool isLifetimeFreeUser;

  const PurchasesDataState({required this.isLifetimeFreeUser});

  @override
  List<Object> get props => [isLifetimeFreeUser];

  PurchasesDataState copyWith({bool? isLifetimeFreeUser}) {
    return PurchasesDataState(
      isLifetimeFreeUser: isLifetimeFreeUser ?? this.isLifetimeFreeUser,
    );
  }

  factory PurchasesDataState.initial() {
    return const PurchasesDataState(
      // New users get lifetime free access to the app by default
      isLifetimeFreeUser: true,
    );
  }

  Map<String, dynamic> toMap() {
    return {'isLifetimeFreeUser': isLifetimeFreeUser};
  }

  factory PurchasesDataState.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {'isLifetimeFreeUser': final bool isLifetimeFreeUser} =>
        PurchasesDataState(isLifetimeFreeUser: isLifetimeFreeUser),
      _ => PurchasesDataState.initial(),
    };
  }
}
