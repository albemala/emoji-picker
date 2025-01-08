// ignore_for_file: avoid_print

// run as dart scripts/generate-store-assets.dart

import 'dart:io';

import 'package:path/path.dart' as path;

void main() {
  generateAndroidStoreAssets();
  generateAppleStoreAssets('ios');
  generateAppleStoreAssets('macos');
}

final androidLanguageMap = {
  'de': 'de-DE',
  'en': 'en-US',
  'es': 'es-ES',
  'fr': 'fr-FR',
  'it': 'it-IT',
  'ja': 'ja-JP',
  'ko': 'ko-KR',
  'zh': 'zh-CN',
};

final appleLanguageMap = {
  'de': 'de-DE',
  'en': 'en-US',
  'es': 'es-ES',
  'fr': 'fr-FR',
  'it': 'it',
  'ja': 'ja',
  'ko': 'ko',
  'zh': 'zh-Hans',
};

void generateAndroidStoreAssets() {
  final sourceDir = Directory('store-assets');
  final targetDir = Directory('android/fastlane/metadata/android');

  final fileMap = {
    'app-name': 'title.txt',
    'short-description': 'short_description.txt',
    'full-description': 'full_description.txt',
  };

  copyFiles(sourceDir, targetDir, fileMap, androidLanguageMap);
  copyAndroidChangelogs(sourceDir, targetDir);

  print('Android file copying completed.');
}

void generateAppleStoreAssets(String platform) {
  final sourceDir = Directory('store-assets');
  final targetDir = Directory('$platform/fastlane/metadata');

  final fileMap = {
    'app-name': 'name.txt',
    'subtitle': 'subtitle.txt',
    'keywords': 'keywords.txt',
    'full-description': 'description.txt',
  };

  copyFiles(sourceDir, targetDir, fileMap, appleLanguageMap);
  copyAppleReleaseNotes(sourceDir, targetDir);

  print('$platform file copying completed.');
}

void copyFiles(
  Directory sourceDir,
  Directory targetDir,
  Map<String, String> fileMap,
  Map<String, String> languageMap,
) {
  for (final entry in fileMap.entries) {
    final sourceFolder = Directory(path.join(sourceDir.path, entry.key));
    if (sourceFolder.existsSync()) {
      for (final file in sourceFolder.listSync()) {
        if (file is File) {
          final lang = path.basenameWithoutExtension(file.path);
          final targetLang = languageMap[lang] ?? lang;
          final targetFile = File(
            path.join(
              targetDir.path,
              targetLang,
              entry.value,
            ),
          );
          targetFile.createSync(recursive: true);
          file.copySync(targetFile.path);
          print('Copied ${file.path} to ${targetFile.path}');
        }
      }
    }
  }
}

void copyAndroidChangelogs(Directory sourceDir, Directory targetDir) {
  final changelogsDir = Directory(
    path.join(
      sourceDir.path,
      'changelogs',
    ),
  );
  if (changelogsDir.existsSync()) {
    for (final versionDir in changelogsDir.listSync()) {
      if (versionDir is Directory) {
        final version = path.basename(versionDir.path);
        for (final file in versionDir.listSync()) {
          if (file is File) {
            final lang = path.basenameWithoutExtension(file.path);
            final targetLang = androidLanguageMap[lang] ?? lang;
            final targetFile = File(
              path.join(
                targetDir.path,
                targetLang,
                'changelogs',
                '$version.txt',
              ),
            );
            targetFile.createSync(recursive: true);
            file.copySync(targetFile.path);
            print('Copied ${file.path} to ${targetFile.path}');
          }
        }
      }
    }
  }
}

void copyAppleReleaseNotes(Directory sourceDir, Directory targetDir) {
  final changelogsDir = Directory(
    path.join(
      sourceDir.path,
      'changelogs',
    ),
  );
  if (changelogsDir.existsSync()) {
    final versions = changelogsDir
        .listSync()
        .whereType<Directory>()
        .map((dir) => int.tryParse(path.basename(dir.path)) ?? 0)
        .where((version) => version > 0)
        .toList()
      ..sort((a, b) => b.compareTo(a));

    if (versions.isNotEmpty) {
      final latestVersion = versions.first;
      final latestChangelogDir = Directory(
        path.join(
          changelogsDir.path,
          latestVersion.toString(),
        ),
      );

      for (final file in latestChangelogDir.listSync()) {
        if (file is File) {
          final lang = path.basenameWithoutExtension(file.path);
          final targetLang = appleLanguageMap[lang] ?? lang;
          final targetFile = File(
            path.join(
              targetDir.path,
              targetLang,
              'release_notes.txt',
            ),
          );
          targetFile.createSync(recursive: true);
          file.copySync(targetFile.path);
          print('Copied ${file.path} to ${targetFile.path}');
        }
      }
    }
  }
}
