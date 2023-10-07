import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';

/// Share a text with another app.
///
/// Returns a [String] with the name of the app it was shared with.
Future<String?> shareText({
  required Rect position,
  required String text,
}) async {
  try {
    final result = await Share.shareWithResult(
      text,
      sharePositionOrigin: position,
    );
    return result.status == ShareResultStatus.success //
        ? result.raw
        : null;
  } catch (exception) {
    if (kDebugMode) print('Failed to share text $exception');
    return null;
  }
}

/// Share a file with another app.
///
/// Returns a [String] with the name of the app it was shared with.
Future<String?> shareFile({
  required Rect position,
  required String filePath,
  String? text,
}) async {
  try {
    final result = await Share.shareXFiles(
      [filePath].map(XFile.new).toList(),
      text: text,
      sharePositionOrigin: position,
    );
    return result.status == ShareResultStatus.success //
        ? result.raw
        : null;
  } catch (exception) {
    if (kDebugMode) print('Failed to share file $exception');
    return null;
  }
}

Rect getSharePosition(BuildContext context) {
  // On iOS and Android phones, this property is ignored
  // (The Share Sheet appears from the bottom).

  const defaultOffset = Offset.zero;
  const defaultSize = Size.square(1);
  try {
    final box = context.findRenderObject() as RenderBox?;
    final offset = box?.localToGlobal(Offset.zero) ?? defaultOffset;
    final size = box?.size ?? defaultSize;
    return offset & size;
  } catch (_) {
    return defaultOffset & defaultSize;
  }
}
