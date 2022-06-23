import 'dart:io';

import 'build_utils.dart';

Future<void> main() async {
  final pubspecFile = File('pubspec.yaml');
  final appVersion = await getVersion(pubspecFile);
  final version = '${appVersion.major}.${appVersion.minor}.${appVersion.patch}';

  final environment = readEnvFile(File('.env'));

  // Install gems
  await installAndUpdateFastlane(directory: '.');

  // Create new GitHub release
  final bundleExecFastlaneResult = await Process.run(
    'bundle',
    ['exec', 'fastlane', 'create_release', 'version:"$version"'],
    workingDirectory: '.',
    environment: environment,
  );
  evaluateResult(bundleExecFastlaneResult);
}
