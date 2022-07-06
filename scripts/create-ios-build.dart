import 'package:flutter_build_helpers/flutter_build_helpers.dart';

Future<void> main() async {
  final environment = readEnvFile(path: '.env');

  // Install gems
  await installFastlane(directory: 'ios');
  await updateFastlane(directory: 'ios');

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
