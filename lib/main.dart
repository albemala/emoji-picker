import 'package:app/app/view.dart';
import 'package:app/glyph-details/bloc.dart';
import 'package:app/glyphs/bloc.dart';
import 'package:app/local-store/bloc.dart';
import 'package:app/preferences/bloc.dart';
import 'package:app/routing/functions.dart';
import 'package:app/search/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_management/flutter_state_management.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  runApp(
    const ConductorCreator(
      create: RoutingConductor.fromContext,
      child: ConductorCreator(
        create: LocalStorageConductor.fromContext,
        child: ConductorCreator(
          create: PreferencesConductor.fromContext,
          child: ConductorCreator(
            create: GlyphsConductor.fromContext,
            child: ConductorCreator(
              create: SearchGlyphsConductor.fromContext,
              child: ConductorCreator(
                create: GlyphDetailsConductor.fromContext,
                child: AppView(),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
