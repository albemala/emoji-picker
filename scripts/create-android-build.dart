import 'dart:io';

import 'package:flutter_build_helpers/flutter_build_helpers.dart';

Future<void> main() async {
  final environment = readEnvFile(File('.env'));

  // Clean previous builds
  deleteDirectory('android/build');
  await runFlutterClean();

  // Build
  await runFlutterBuild('appbundle');

  // Publish to App Store
  await runFastlane(
    platform: 'android',
    lane: 'stable',
    directory: 'android',
    environment: environment,
  );
}
