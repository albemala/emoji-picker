import 'package:app/conductors/preferences-conductor.dart';
import 'package:app/conductors/routing-conductor.dart';
import 'package:app/defines/app-theme.dart';
import 'package:app/functions/app.dart';
import 'package:app/intents-actions.dart';
import 'package:app/views/app-content.dart';
import 'package:cross_platform/cross_platform.dart' as cross_platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_state_management/flutter_state_management.dart';

class AppViewCreator extends StatelessWidget {
  const AppViewCreator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConductorConsumer<PreferencesConductor>(
      builder: (context, preferencesConductor) {
        return AppView(
          preferencesConductor: preferencesConductor,
        );
      },
    );
  }
}

class AppView extends StatelessWidget {
  final PreferencesConductor preferencesConductor;

  const AppView({
    super.key,
    required this.preferencesConductor,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: preferencesConductor.themeMode,
      builder: (context, themeMode, child) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarBrightness: themeMode == ThemeMode.dark
                ? Brightness.dark
                : Brightness.light,
          ),
        );

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: getAppName(),
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: child,
        );
      },
      child: RoutingView(
        routingStream: context.getConductor<RoutingConductor>().routingStream,
        child: Shortcuts(
          shortcuts: {
            // focus search
            if (cross_platform.Platform.isMacOS) //
              LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyF):
                  const FocusSearchIntent(),
            if (cross_platform.Platform.isWindows ||
                cross_platform.Platform.isLinux) //
              LogicalKeySet(
                      LogicalKeyboardKey.control, LogicalKeyboardKey.keyF):
                  const FocusSearchIntent(),
            // copy glyph
            if (cross_platform.Platform.isMacOS) //
              LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyC):
                  const CopyGlyphIntent(),
            if (cross_platform.Platform.isWindows ||
                cross_platform.Platform.isLinux) //
              LogicalKeySet(
                      LogicalKeyboardKey.control, LogicalKeyboardKey.keyC):
                  const CopyGlyphIntent(),
          },
          child: Actions(
            actions: {
              // FocusSearchIntent: FocusSearchAction(searchViewFocusNode),
              // CopyGlyphIntent: CopyGlyphAction(context, glyphWithDetails?.char),
            },
            child: const AppContentView(),
          ),
        ),
      ),
    );
  }
}
