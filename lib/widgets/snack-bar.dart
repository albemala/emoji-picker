import 'package:app/theme/text.dart';
import 'package:flutter/material.dart';

SnackBar createCopiedToClipboardSnackBar(BuildContext context, String char) {
  final textStyle = getTitleTextStyle(context).copyWith(
    color: Theme.of(context).colorScheme.onInverseSurface,
  );
  return SnackBar(
    content: Row(
      children: [
        Flexible(
          child: Text(
            char,
            overflow: TextOverflow.ellipsis,
            style: textStyle,
          ),
        ),
        Text(
          ' copied to clipboard',
          style: textStyle,
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    backgroundColor: Theme.of(context).colorScheme.inverseSurface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(16),
    ),
    behavior: SnackBarBehavior.floating,
    width: 320,
    duration: const Duration(seconds: 3),
  );
}
