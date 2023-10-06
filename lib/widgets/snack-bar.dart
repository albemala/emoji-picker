import 'package:flutter/material.dart';

SnackBar createCopiedToClipboardSnackBar(String char) {
  return SnackBar(
    content: Row(
      children: [
        Flexible(
          child: Text(
            char,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Text(
          ' copied to clipboard',
        ),
      ],
    ),
    behavior: SnackBarBehavior.floating,
    width: 240,
    duration: const Duration(seconds: 3),
  );
}
