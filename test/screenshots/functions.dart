// import 'package:app/generated/l10n.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
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
  ScreenshotDevice.screenshotsFolder =
      '../../temp/screenshots/${locale.languageCode}/';

  final customDevice = ScreenshotDevice(
    platform: device.device.platform,
    resolution: device.device.resolution,
    pixelRatio: device.device.pixelRatio,
    goldenSubFolder: device.device.goldenSubFolder,
    frameBuilder:
        ({
          required device,
          required frameColors,
          required child,
        }) {
          return ScreenshotFrame.noFrame(
            device: device,
            frameColors: frameColors,
            child: child,
          );
        },
  );

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
    device: customDevice,
    home: child,
  );

  await tester.runAsync(() => tester.pumpWidget(widget));
  await tester.loadAssets();
  await tester.pumpFrames(widget, const Duration(seconds: 1));
  await tester.expectScreenshot(
    device.device,
    goldenFileName,
  );
}
