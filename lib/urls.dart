import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

const supportEmailUrl = 'albemala@gmail.com';

const twitterUrl = 'https://twitter.com/albemala';
const repositoryUrl = 'https://github.com/albemala/emoji-picker';

String get otherProjectsUrl {
  switch (Platform.operatingSystem) {
    case 'ios':
    case 'macos':
      return 'https://apps.apple.com/us/app/emoji-kaomoji-symbols-ejimo/id1598944603';
    default:
      return 'https://projects.albemala.me/?ref=ejimo-app';
  }
}

Future<void> openUrl(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  await openUri(uri);
}

Future<void> openUri(Uri uri) async {
  final canOpenUrl = await canLaunchUrl(uri);
  if (!canOpenUrl) return;
  await launchUrl(uri);
}
