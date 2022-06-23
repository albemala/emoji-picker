// ignore_for_file: avoid_print

import 'dart:io';

import 'build_utils.dart';

Future<void> main() async {
  final pubspecFile = File('pubspec.yaml');
  final appVersion = await getVersion(pubspecFile);
  final version = '${appVersion.major}.${appVersion.minor}.${appVersion.patch}';

  final environment = readEnvFile(File('.env'));

  final archivePath = 'windows-builds/$version';
  final appStoreArchivePath = '$archivePath/appstore';
  final standaloneArchivePath = '$archivePath/standalone';

  print('------ Setup ------');

  await runFlutterClean();
  // Remove existing archive folder for this version
  deleteDirectory(archivePath);

  // Create archive folders
  createDirectory(appStoreArchivePath);
  createDirectory(standaloneArchivePath);

  await runFlutterBuild('windows');

  print('------ Build App Store ------');

  // Build
  print('Running msix');
  final flutterBuildResult = await Process.run(
    'flutter',
    [
      'pub',
      'run',
      'msix:create',
      '--store',
      '-i',
      environment['IdentityName'] ?? '',
      '-b',
      environment['Publisher'] ?? '',
      '-u',
      environment['PublisherDisplayName'] ?? '',
    ],
  );
  evaluateResult(flutterBuildResult);

  print('------ Archive App Store ------');

  copyFile(
    from: 'build/windows/runner/Release/app.msix',
    to: '$appStoreArchivePath/Ejimo.msix',
  );

  print('------ Archive Standalone ------');

  copyDirectory(from: 'build/windows/runner/Release/data', to: standaloneArchivePath);
  copyFiles(pattern: 'build/windows/runner/Release/*.dll', to: standaloneArchivePath);
  copyFile(from: 'build/windows/runner/Release/Ejimo.exe', to: '$standaloneArchivePath/Ejimo.exe');
  copyFile(from: 'C:/Windows/System32/msvcp140.dll', to: '$standaloneArchivePath/msvcp140.dll');
  copyFile(from: 'C:/Windows/System32/vcruntime140.dll', to: '$standaloneArchivePath/vcruntime140.dll');
  copyFile(from: 'C:/Windows/System32/vcruntime140_1.dll', to: '$standaloneArchivePath/vcruntime140_1.dll');

  // Compress standalone app
  zipDirectory(path: standaloneArchivePath);
}
