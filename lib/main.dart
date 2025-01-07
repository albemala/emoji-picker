import 'package:app/app/view.dart';
import 'package:app/glyph-data/data-controller.dart';
import 'package:app/local-store/bloc.dart';
import 'package:app/preferences/data-controller.dart';
import 'package:app/search/data-controller.dart';
import 'package:app/selected-glyph/data-controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  GoogleFonts.config.allowRuntimeFetching = false;

  runApp(
    MultiBlocProvider(
      providers: const [
        BlocProvider(create: LocalStoreDataController.fromContext),
        BlocProvider(create: PreferencesDataController.fromContext),
        BlocProvider(create: GlyphsDataController.fromContext),
        BlocProvider(create: SearchGlyphsDataController.fromContext),
        BlocProvider(create: SelectedGlyphDataController.fromContext),
      ],
      child: const AppViewCreator(),
    ),
  );
}
