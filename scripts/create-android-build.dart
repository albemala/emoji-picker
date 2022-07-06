import 'package:flutter_build_helpers/flutter_build_helpers.dart';

Future<void> main() async {
  final environment = readEnvFile(path: '.env');

  // Install gems
  await installFastlane(directory: 'android');
  await updateFastlane(directory: 'android');

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
