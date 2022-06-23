import 'dart:io';

import 'build_utils.dart';

Future<void> main() async {
  // Clean previous builds
  deleteDirectory('android/build');
  await runFlutterClean();

  // Install gems
  await installAndUpdateFastlane(directory: 'android');

  // Build and publish to App Store
  await runFlutterBuild('appbundle');
  await runFastlane(
    platform: 'android',
    lane: 'stable',
    directory: 'android',
    environment: readEnvFile(File('.env')),
  );
}
