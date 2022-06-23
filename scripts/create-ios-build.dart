import 'dart:io';

import 'build_utils.dart';

Future<void> main() async {
  // Clean previous builds
  deleteDirectory('ios/build');
  await runFlutterClean();

  // Install gems
  await installAndUpdateFastlane(directory: 'ios');

  // Build and publish to App Store
  await runFlutterBuild('ios');
  await runFastlane(
    directory: 'ios',
    platform: 'ios',
    lane: 'app_store',
    environment: readEnvFile(File('.env')),
  );
}
