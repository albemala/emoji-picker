import 'package:app/app-content/view.dart';
import 'package:app/app/defines.dart';
import 'package:app/app/intents-actions.dart';
import 'package:app/app/theme.dart';
import 'package:app/glyph-details/bloc.dart';
import 'package:app/preferences/bloc.dart';
import 'package:app/routing/functions.dart';
import 'package:app/search/bloc.dart';
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
          title: appName,
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
                context.getConductor<GlyphDetailsConductor>(),
              ),
            },
            child: const AppContentView(),
          ),
        ),
      ),
    );
  }
}
