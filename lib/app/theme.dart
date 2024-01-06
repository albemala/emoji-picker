import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = FlexThemeData.light(
  scheme: FlexScheme.material,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 7,
  subThemesData: const FlexSubThemesData(
    defaultRadius: 32,
    useM2StyleDividerInM3: true,
  ),
  keyColors: const FlexKeyColors(
    useSecondary: true,
    useTertiary: true,
  ),
  tones: FlexTones.vivid(Brightness.light),
  useMaterial3: true,
  visualDensity: VisualDensity.compact,
  fontFamily: GoogleFonts.titilliumWeb().fontFamily,
);

final darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.material,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 13,
  subThemesData: const FlexSubThemesData(
    useM2StyleDividerInM3: true,
    defaultRadius: 32,
  ),
  keyColors: const FlexKeyColors(
    useSecondary: true,
    useTertiary: true,
  ),
  tones: FlexTones.vivid(Brightness.dark),
  useMaterial3: true,
  visualDensity: VisualDensity.compact,
  fontFamily: GoogleFonts.titilliumWeb().fontFamily,
);
