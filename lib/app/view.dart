import 'package:app/app-content/view.dart';
import 'package:app/app/defines.dart';
import 'package:app/app/intents-actions.dart';
import 'package:app/app/theme.dart';
import 'package:app/glyph-details/bloc.dart';
import 'package:app/glyphs/bloc.dart';
import 'package:app/local-store/bloc.dart';
import 'package:app/preferences/bloc.dart';
import 'package:app/search/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: const [
        BlocProvider(create: LocalStoreBloc.fromContext),
        BlocProvider(create: PreferencesBloc.fromContext),
        BlocProvider(create: GlyphsBloc.fromContext),
        BlocProvider(create: SearchGlyphsBloc.fromContext),
        BlocProvider(create: GlyphDetailsBloc.fromContext),
      ],
      child: BlocBuilder<PreferencesBloc, PreferencesState>(
        builder: (context, preferences) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarBrightness: preferences.themeMode == ThemeMode.dark
                  ? Brightness.dark
                  : Brightness.light,
            ),
          );

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: appName,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: preferences.themeMode,
            home: Builder(
              builder: (context) {
                return Shortcuts(
                  shortcuts: shortcuts,
                  child: Actions(
                    actions: {
                      FocusSearchIntent: FocusSearchAction(context),
                      CopyGlyphIntent: CopyGlyphAction(context),
                    },
                    child: const AppContentView(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
