import 'dart:io';

Future<void> main() async {
  final pubspecFile = File('../pubspec.yaml');
  final pubspec = await pubspecFile.readAsString();
  final version = RegExp(
    r'^version:\s*(.*)\+(.*)$',
    multiLine: true,
  ).firstMatch(pubspec)?.group(1);
  stdout.write(version);
}
