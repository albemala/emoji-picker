import 'package:flutter_build_helpers/flutter_build_helpers.dart';

Future<void> main() async {
  final fullVersion = await getFullVersion(pubspecFilePath: 'pubspec.yaml');
  final version = getVersion(fullVersion);

  final environment = readEnvFile(path: '.env');

  // Install gems
  await installFastlane(directory: '.');
  await updateFastlane(directory: '.');

  // Create new GitHub release
  await runCommand(
    'bundle',
    ['exec', 'fastlane', 'create_release', 'version:$version'],
    workingDirectory: '.',
    environment: environment,
  );
}
