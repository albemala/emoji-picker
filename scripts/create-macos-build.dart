// ignore_for_file: avoid_print

import 'dart:io';

import 'build_utils.dart';

Future<void> main() async {
  final pubspecFile = File('pubspec.yaml');
  final appVersion = await getVersion(pubspecFile);
  final version = '${appVersion.major}.${appVersion.minor}.${appVersion.patch}';

  final environment = readEnvFile(File('.env'));

  const buildPath = 'macos/build';

  final archivePath = 'macos-builds/$version';
  final appStoreArchivePath = '$archivePath/appstore';
  final standaloneArchivePath = '$archivePath/standalone';

  print('------ Setup ------');

  await runFlutterClean();
  // Remove existing archive folder for this version
  deleteDirectory(archivePath);

  // Create archive folders
  // createDirectory(appStoreArchivePath);
  createDirectory(standaloneArchivePath);

  // Install gems
  await installAndUpdateFastlane(directory: 'macos');

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
