import 'package:app/clipboard.dart';
import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/recent/data-controller.dart';
import 'package:app/routing.dart';
import 'package:app/widgets/snack-bar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> copyGlyphToClipboard(BuildContext context, Glyph glyph) async {
  await copyToClipboard(glyph.glyph);
  context.read<RecentDataController>().addRecentGlyph(glyph);
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
  showSnackBar(
    context, //
    createCopiedToClipboardSnackBar(context, glyph.htmlCode),
  );
}
