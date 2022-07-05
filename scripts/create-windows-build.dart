// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter_build_helpers/flutter_build_helpers.dart';

Future<void> main() async {
  final pubspecFile = File('pubspec.yaml');
  final fullVersion = await getFullVersion(pubspecFile);
  final version = getVersion(fullVersion);

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
  await runCommand(
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
  zipDirectory(
    path: standaloneArchivePath,
    zipFilePath: '$standaloneArchivePath/Ejimo-Windows-$version.zip',
  );
}
