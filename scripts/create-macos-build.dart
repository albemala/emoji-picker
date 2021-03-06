// ignore_for_file: avoid_print

import 'package:flutter_build_helpers/flutter_build_helpers.dart';

Future<void> main() async {
  final fullVersion = await getFullVersion(pubspecFilePath: 'pubspec.yaml');
  final version = getVersion(fullVersion);

  final environment = readEnvFile(path: '.env');

  const buildPath = 'macos/build';

  final archivePath = 'macos-builds/$version';
  // final appStoreArchivePath = '$archivePath/appstore';
  final standaloneArchivePath = '$archivePath/standalone';

  print('------ Setup ------');

  // Install gems
  await installFastlane(directory: 'macos');
  await updateFastlane(directory: 'macos');

  // Remove existing archive folder for this version
  deleteDirectory(archivePath);
  // Create archive folders
  // createDirectory(appStoreArchivePath);
  createDirectory(standaloneArchivePath);

  await runFlutterClean();

  await runFlutterBuild('macos');

  print('------ Build App Store ------');

  // Clean previous builds
  deleteDirectory(buildPath);
  // Build
  await runFastlane(
    directory: 'macos',
    platform: 'mac',
    lane: 'app_store',
    environment: environment,
  );

  print('------ Build Standalone ------');

  // Clean previous builds
  deleteDirectory(buildPath);
  // Build
  await runFastlane(
    directory: 'macos',
    platform: 'mac',
    lane: 'standalone',
    environment: environment,
  );

  print('------ Archive Standalone ------');

  // Copy app
  copyFile(
    from: '$buildPath/Ejimo.app.zip',
    to: '$standaloneArchivePath/Ejimo-macOS-$version.zip',
  );
  // Copy symbols
  copyFile(
    from: '$buildPath/Ejimo.app.dSYM.zip',
    to: '$standaloneArchivePath/Ejimo-macOS-$version.dSYM.zip',
  );
}
