import 'package:emoji_picker/app/view.dart';
import 'package:emoji_picker/app_usage/data-controller.dart';
import 'package:emoji_picker/favorites/data-controller.dart';
import 'package:emoji_picker/glyph-data/data-controller.dart';
import 'package:emoji_picker/preferences/data-controller.dart';
import 'package:emoji_picker/purchases/data-controller.dart';
import 'package:emoji_picker/recent/data-controller.dart';
import 'package:emoji_picker/search/data-controller.dart';
import 'package:emoji_picker/selected-glyph/data-controller.dart';
import 'package:emoji_picker/selected-tab/data-controller.dart';
import 'package:emoji_picker/sentry.dart';
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
              create: PurchasesDataController.fromContext,
              lazy: false, //
            ),
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
              create: FavoritesDataController.fromContext,
              lazy: false, //
            ),
            BlocProvider(
              create: RecentDataController.fromContext,
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
