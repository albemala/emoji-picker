// ignore_for_file: avoid_print

import 'dart:io';

import 'package:pub_semver/pub_semver.dart';

import 'build_utils.dart';

/// Usage: dart scripts/set-app-version.dart x.y.z
Future<void> main(List<String> arguments) async {
  // print(arguments);
  if (arguments.length != 1) {
    print('pass new version as first and only argument');
    return;
  }

  final pubspecFile = File('pubspec.yaml');

  final currentAppVersion = await getVersion(pubspecFile);
  final currentBuildNumber = currentAppVersion.build.first as int? ?? 1;

  final newVersion = Version.parse(arguments[0]);
  final newBuildNumber = currentBuildNumber + 1;
  final newAppVersion = Version(
    newVersion.major,
    newVersion.minor,
    newVersion.patch,
    build: newBuildNumber.toString(),
  );

  final newMsixVersion = [
    newVersion.major,
    newVersion.minor,
    newVersion.patch,
    0,
  ].join('.');

  final newWindowsVersionAsNumber = [
    newVersion.major,
    newVersion.minor,
    newVersion.patch,
  ].join(',');
  final newWindowsVersionAsString = [
    newVersion.major,
    newVersion.minor,
    newVersion.patch,
  ].join('.');

  // Set pubspec.yaml version
  final newPubspec = pubspecFile //
      .readAsStringSync()
      .replaceFirst(
        RegExp(r'version:\s*.*', multiLine: true),
        'version: $newAppVersion',
      )
      .replaceFirst(
        RegExp(r'msix_version:\s*.*', multiLine: true),
        'msix_version: $newMsixVersion',
      );
  pubspecFile.writeAsStringSync(newPubspec);

  // Set Windows Runner.rc version
  final windowsRunnerFile = File('windows/runner/Runner.rc');
  final newWindowsRunner = windowsRunnerFile
      .readAsStringSync()
      .replaceFirst(
        RegExp(r'VERSION_AS_NUMBER\s*[\d,]+', multiLine: true),
        'VERSION_AS_NUMBER $newWindowsVersionAsNumber',
      )
      .replaceFirst(
        RegExp(r'VERSION_AS_STRING\s*["\d.]+', multiLine: true),
        'VERSION_AS_STRING "$newWindowsVersionAsString"',
      );
  windowsRunnerFile.writeAsStringSync(newWindowsRunner);
}
