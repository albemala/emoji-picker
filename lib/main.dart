import 'package:app/app/view.dart';
import 'package:app/app_usage/data-controller.dart';
import 'package:app/glyph-data/data-controller.dart';
import 'package:app/preferences/data-controller.dart';
import 'package:app/search/data-controller.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:app/selected-tab/data-controller.dart';
import 'package:app/sentry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GoogleFonts.config.allowRuntimeFetching = false;

  await SentryFlutter.init(
    configureSentry,
    appRunner: () {
      runApp(
        MultiBlocProvider(
          providers: const [
            BlocProvider(
              create: AppUsageDataController.fromContext,
              lazy: false, //
            ),
            BlocProvider(
              create: PreferencesDataController.fromContext,
              lazy: false, //
            ),
            BlocProvider(
              create: GlyphsDataController.fromContext,
              lazy: false, //
            ),
            BlocProvider(
              create: SearchGlyphsDataController.fromContext,
              lazy: false, //
            ),
            BlocProvider(
              create: SelectedGlyphDataController.fromContext,
              lazy: false, //
            ),
            BlocProvider(
              create: SelectedTabDataController.fromContext,
              lazy: false, //
            ),
          ],
          child: const AppViewCreator(),
        ),
      );
    },
  );
}
