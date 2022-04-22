import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> copyToClipboard(BuildContext context, String? text) async {
  if (text == null || text.isEmpty) return;

  await FlutterClipboard.copy(text);

  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline5?.fontSize,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'copied to clipboard',
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.subtitle1?.fontSize,
              fontFamily: GoogleFonts.titilliumWeb().fontFamily,
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      width: 240,
      duration: const Duration(seconds: 3),
    ),
  );
}
