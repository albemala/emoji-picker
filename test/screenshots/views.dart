import 'package:flutter/material.dart';

class ScreenshotDialogView extends StatelessWidget {
  final Widget child;

  const ScreenshotDialogView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: child,
          ),
        ),
      ),
    );
  }
}
