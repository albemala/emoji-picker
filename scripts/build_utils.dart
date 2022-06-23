// ignore_for_file: avoid_print

import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:io/io.dart';
import 'package:pub_semver/pub_semver.dart';

// Directory

void deleteDirectory(String path) {
  try {
    Directory(path).deleteSync(recursive: true);
  } catch (_) {}
}

void createDirectory(String path) {
  Directory(path).createSync(recursive: true);
}

void copyDirectory({
  required String from,
  required String to,
}) {
  copyPathSync(from, to);
}

void zipDirectory({
  required String path,
}) {
  final standaloneArchive = createArchiveFromDirectory(
    Directory(path),
    includeDirName: false,
  );
  ZipEncoder().encode(
    standaloneArchive,
    level: Deflate.DEFAULT_COMPRESSION,
  );
}

// File

/// Note: [to] must be a File path, not a Directory path.
File copyFile({
  required String from,
  required String to,
}) {
  return File(from).copySync(to);
}

void copyFiles({
  required String pattern,
  required String to,
}) {
  final glob = Glob(pattern);
  for (final item in glob.listSync()) {
    if (item is File) {
      (item as File).copySync(to);
    }
  }
}

// Version

Future<Version> getVersion(File pubspecFile) async {
  final pubspec = await pubspecFile.readAsString();
  final version = RegExp(
        r'^version:\s*(.*)$',
        multiLine: true,
      ) //
          .firstMatch(pubspec)
          ?.group(1) ??
      '';
  return Version.parse(version);
}

// Run commands

Future<void> runFlutterClean() async {
  print('Running flutter clean');
  final flutterCleanResult = await Process.run(
    'flutter',
    ['clean'],
  );
  evaluateResult(flutterCleanResult);
}

Future<void> runFlutterBuild(String platform) async {
  print('Running flutter build $platform');
  final flutterBuildResult = await Process.run(
    'flutter',
    ['build', platform, '--release'],
  );
  evaluateResult(flutterBuildResult);
}

Future<void> installAndUpdateFastlane({
  required String directory,
}) async {
  print('Installing fastlane');

  final bundleInstallResult = await Process.run(
    'bundle',
    ['install'],
    workingDirectory: directory,
  );
  evaluateResult(bundleInstallResult);

  final bundleUpdateResult = await Process.run(
    'bundle',
    ['update', 'fastlane'],
    workingDirectory: directory,
  );
  evaluateResult(bundleUpdateResult);
}

Future<void> runFastlane({
  required String directory,
  required String platform,
  required String lane,
  required Map<String, String> environment,
}) async {
  print('Running fastlane $lane');
  final bundleExecFastlaneResult = await Process.run(
    'bundle',
    ['exec', 'fastlane', platform, lane],
    workingDirectory: directory,
    environment: environment,
  );
  evaluateResult(bundleExecFastlaneResult);
}

Map<String, String> readEnvFile(File envFile) {
  final envFileContents = envFile //
      .readAsLinesSync()
      // Remove empty lines
      .where((line) => line.trim().isNotEmpty)
      .toList();
  return Map<String, String>.fromEntries(
    envFileContents.map(
      (line) {
        final split = line.split('=');
        return MapEntry(
          split[0],
          split[1],
        );
      },
    ),
  );
}

void evaluateResult(ProcessResult processResult) {
  print(processResult.exitCode);
  print(processResult.stdout);
  if (processResult.exitCode != 0) {
    throw Exception(processResult.stderr);
  }
}
