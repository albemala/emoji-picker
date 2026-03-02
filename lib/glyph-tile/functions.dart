import 'dart:async';

import 'package:emoji_picker/app_usage/data-controller.dart';
import 'package:emoji_picker/glyph-data/defines/glyph.dart';
import 'package:emoji_picker/recent/data-controller.dart';
import 'package:emoji_picker/widgets/snack-bar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_utils/flutter_utils.dart';

Future<void> copyGlyphToClipboard(BuildContext context, Glyph glyph) async {
  await copyToClipboard(glyph.glyph);

  if (!context.mounted) return;

  context.read<RecentDataController>().addRecentGlyph(glyph);

  final appUsageDataController = context.read<AppUsageDataController>()
    ..incrementGlyphCopiedCount();
  if (appUsageDataController.glyphCopiedCount > 0 &&
      appUsageDataController.glyphCopiedCount % 5 == 0) {
    unawaited(showReviewDialog());
  }

  showSnackBar(
    context, //
    createCopiedToClipboardSnackBar(context, glyph.glyph),
  );
}

Future<void> copyGlyphUnicodeToClipboard(
  BuildContext context,
  Glyph glyph,
) async {
  await copyToClipboard(glyph.unicode);

  if (!context.mounted) return;

  showSnackBar(
    context, //
    createCopiedToClipboardSnackBar(context, glyph.unicode),
  );
}

Future<void> copyGlyphHtmlCodeToClipboard(
  BuildContext context,
  Glyph glyph,
) async {
  await copyToClipboard(glyph.htmlCode);

  if (!context.mounted) return;

  showSnackBar(
    context, //
    createCopiedToClipboardSnackBar(context, glyph.htmlCode),
  );
}
