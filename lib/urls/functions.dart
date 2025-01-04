import 'package:url_launcher/url_launcher.dart';

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
