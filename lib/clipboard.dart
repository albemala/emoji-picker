import 'package:clipboard/clipboard.dart';

Future<void> copyToClipboard(String text) async {
  if (text.isEmpty) return;
  await FlutterClipboard.copy(text);
}

Future<String?> pasteFromClipboard() async {
  return FlutterClipboard.paste();
}
