// ignore_for_file: avoid_print

import 'dart:io';

/// Usage: set-app-version.dart x.y.z
void main(List<String> arguments) {
  // print(arguments);
  if (arguments.length != 1) {
    print('pass new version as first and only argument');
    return;
  }
  final newVersion = arguments[0];

  final currentBuildNumber = Process.runSync('dart', ['get-app-build-number.dart']).stdout.toString();
  final newBuildNumber = int.parse(currentBuildNumber) + 1;

  // Set pubspec.yaml version
  final pubspecFile = File('../pubspec.yaml');
  final newPubspec = pubspecFile //
      .readAsStringSync()
      .replaceFirst(
        RegExp(r'version:\s*.*', multiLine: true),
        'version: $newVersion+$newBuildNumber',
      )
      .replaceFirst(
        RegExp(r'msix_version:\s*.*', multiLine: true),
        'msix_version: $newVersion.0',
      );
  pubspecFile.writeAsStringSync(newPubspec);

  // Set Windows Runner.rc version
  final windowsRunnerFile = File('../windows/runner/Runner.rc');
  final newWindowsRunner = windowsRunnerFile
      .readAsStringSync()
      .replaceFirst(
        RegExp(r'VERSION_AS_NUMBER\s*[\d,]+', multiLine: true),
        "VERSION_AS_NUMBER ${newVersion.replaceAll(".", ",")}",
      )
      .replaceFirst(
        RegExp(r'VERSION_AS_STRING\s*["\d.]+', multiLine: true),
        'VERSION_AS_STRING "$newVersion"',
      );
  windowsRunnerFile.writeAsStringSync(newWindowsRunner);
}
