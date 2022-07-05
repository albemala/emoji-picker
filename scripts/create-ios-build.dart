import 'dart:io';

import 'package:flutter_build_helpers/flutter_build_helpers.dart';

Future<void> main() async {
  final environment = readEnvFile(File('.env'));

  // Clean previous builds
  deleteDirectory('ios/build');
  await runFlutterClean();

  // Build
  await runFlutterBuild('ios');

  // Publish to App Store
  await runFastlane(
    directory: 'ios',
    platform: 'ios',
    lane: 'app_store',
    environment: environment,
  );
}
