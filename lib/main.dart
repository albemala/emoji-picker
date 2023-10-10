import 'package:app/conductors/glyph-details-conductor.dart';
import 'package:app/conductors/glyphs-conductor.dart';
import 'package:app/conductors/local-storage-conductor.dart';
import 'package:app/conductors/preferences-conductor.dart';
import 'package:app/conductors/routing-conductor.dart';
import 'package:app/conductors/search-glyphs-conductor.dart';
import 'package:app/views/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_management/flutter_state_management.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
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
