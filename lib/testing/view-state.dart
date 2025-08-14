import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class TestingViewState extends Equatable {
  const TestingViewState();

  @override
  List<Object> get props => [];

  TestingViewState copyWith() {
    return const TestingViewState();
  }
}

const defaultTestingViewState = TestingViewState();
