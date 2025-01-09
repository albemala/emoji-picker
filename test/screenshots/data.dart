import 'package:app/about/view-state.dart';
import 'package:app/about/view.dart';
import 'package:flutter/material.dart';

import 'defines.dart';

Future<List<ScreenshotData>> createScreenshotData() async {
  return [
    ScreenshotData(
      view: ScreenshotDialogView(
        child: AboutView(
          controller: MockAboutViewController(),
          state: createAboutViewStateForScreenshot(),
        ),
      ),
      fileName: 'about_view',
    ),
  ];
}

AboutViewState createAboutViewStateForScreenshot() {
  return defaultAboutViewState.copyWith(
    appVersion: '3.0.0',
  );
}

class ScreenshotData {
  final Widget view;
  final String fileName;

  const ScreenshotData({
    required this.view,
    required this.fileName,
  });
}

class ScreenshotDialogView extends StatelessWidget {
  final Widget child;

  const ScreenshotDialogView({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: AlertDialog(
          clipBehavior: Clip.hardEdge,
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
