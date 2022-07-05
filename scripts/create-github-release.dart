import 'dart:io';

import 'package:flutter_build_helpers/flutter_build_helpers.dart';

Future<void> main() async {
  final pubspecFile = File('pubspec.yaml');
  final fullVersion = await getFullVersion(pubspecFile);
  final version = getVersion(fullVersion);

  final environment = readEnvFile(File('.env'));

  // Create new GitHub release
  await runCommand(
    'fastlane',
    ['create_release', 'version:"$version"'],
    workingDirectory: '.',
    environment: environment,
  );
}
