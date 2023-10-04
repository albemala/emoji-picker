import 'package:clipboard/clipboard.dart';

Future<void> copyToClipboard(String? text) async {
  if (text == null || text.isEmpty) return;
  await FlutterClipboard.copy(text);
}
