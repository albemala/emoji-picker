import 'package:app/conductors/glyph-actions-conductor.dart';
import 'package:app/conductors/preferences-conductor.dart';
import 'package:app/conductors/routing-conductor.dart';
import 'package:app/conductors/search-glyphs-conductor.dart';
import 'package:app/defines/app-theme.dart';
import 'package:app/defines/intents-actions.dart';
import 'package:app/functions/app.dart';
import 'package:app/views/app-content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_state_management/flutter_state_management.dart';

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.getConductor<PreferencesConductor>().themeMode,
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
          shortcuts: shortcuts,
          child: Actions(
            actions: {
              FocusSearchIntent: FocusSearchAction(
                context.getConductor<SearchGlyphsConductor>(),
              ),
              CopyGlyphIntent: CopyGlyphAction(
                context.getConductor<GlyphActionsConductor>(),
              ),
            },
            child: const AppContentView(),
          ),
        ),
      ),
    );
  }
}
