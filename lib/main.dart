import 'package:app/app/view.dart';
import 'package:app/glyph-details/view-controller.dart';
import 'package:app/glyphs/data-controller.dart';
import 'package:app/local-store/bloc.dart';
import 'package:app/preferences/bloc.dart';
import 'package:app/search/bloc.dart';
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
        BlocProvider(create: LocalStoreBloc.fromContext),
        BlocProvider(create: PreferencesBloc.fromContext),
        BlocProvider(create: GlyphsBloc.fromContext),
        BlocProvider(create: SearchGlyphsBloc.fromContext),
        BlocProvider(create: GlyphDetailsBloc.fromContext),
      ],
      child: const AppViewCreator(),
    ),
  );
}
