import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_screenshot/golden_screenshot.dart';

Future<void> takeScreenshot({
  required WidgetTester tester,
  required GoldenScreenshotDevices device,
  required ThemeData theme,
  required Widget child,
  required String goldenFileName,
  Locale locale = const Locale('en'),
}) async {
  debugDisableShadows = false;

  ScreenshotDevice.screenshotsFolder =
      '../../temp/screenshots/${locale.languageCode}/';

  final widget = ScreenshotApp(
    // localizationsDelegates: const [
    //   S.delegate,
    //   GlobalWidgetsLocalizations.delegate,
    //   GlobalMaterialLocalizations.delegate,
    //   GlobalCupertinoLocalizations.delegate,
    // ],
    // supportedLocales: S.delegate.supportedLocales,
    locale: locale,
    theme: theme,
    device: device.device,
    child: child,
  );
  await tester.pumpWidget(widget);

  await tester.precacheImagesInWidgetTree();
  await tester.precacheTopbarImages();
  await tester.loadFonts();

  await tester.pumpFrames(widget, const Duration(seconds: 1));

  await tester.expectScreenshot(device.device, goldenFileName);

  debugDisableShadows = true;
}
