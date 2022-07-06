import 'package:flutter_build_helpers/flutter_build_helpers.dart';

Future<void> main() async {
  final fullVersion = await getFullVersion(pubspecFilePath: 'pubspec.yaml');
  final version = getVersion(fullVersion);

  final environment = readEnvFile(path: '.env');

  final archivePath = 'web-builds/$version';

  print('------ Setup ------');

  // Remove existing archive folder for this version
  deleteDirectory(archivePath);
  // Create archive folders
  createDirectory(archivePath);

  await runFlutterClean();

  print('------ Build ------');

  // Build and publish to App Store
  await runFlutterBuild('web', ['--source-maps']);

  print('------ Upload source maps to Sentry ------');

  final sentryRelease = 'me.albemala.ejimo@$fullVersion';
  final sentryOrg = environment['SENTRY_ORG'] ?? '';
  const sentryProject = 'ejimo';

  await createSentryRelease(
    sentryOrg: sentryOrg,
    sentryProject: sentryProject,
    sentryRelease: sentryRelease,
  );
  await uploadSentrySourcemaps(
    sentryOrg: sentryOrg,
    sentryProject: sentryProject,
    sentryRelease: sentryRelease,
  );
  await finalizeSentryRelease(
    sentryOrg: sentryOrg,
    sentryProject: sentryProject,
    sentryRelease: sentryRelease,
  );

  print('------ Upload build to Firebase Hosting ------');

  await uploadToFirebaseHosting();

  print('------ Archive ------');

  zipDirectory(
    path: 'build/web',
    zipFilePath: '$archivePath/Ejimo-Web-$version.zip',
  );
}
