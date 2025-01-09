import 'package:app/about/view-controller.dart';
import 'package:app/preferences/data-controller.dart';
import 'package:app/preferences/data-state.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext //
    extends Mock implements BuildContext {}

class MockPreferencesDataController //
    extends Mock implements PreferencesDataController {
  @override
  Stream<PreferencesDataState> get stream {
    return Stream.value(defaultPreferencesDataState);
  }

  @override
  PreferencesDataState get state {
    return defaultPreferencesDataState;
  }
}

class MockAboutViewController //
    extends Mock implements AboutViewController {}
