import 'dart:ui';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = FlexThemeData.light(
  colors: const FlexSchemeColor(
    primary: Color(0xff8B5CF6),
    primaryVariant: Color(0xff4C1D95),
    secondary: Color(0xff34D399),
    secondaryVariant: Color(0xff34D399),
    appBarColor: Color(0xff34D399),
    error: Color(0xffE11D48),
  ),
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 16,
  tooltipsMatchBackground: true,
  swapColors: false,
  lightIsWhite: false,
  useSubThemes: true,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  fontFamily: GoogleFonts.titilliumWeb().fontFamily,
  subThemesData: const FlexSubThemesData(
    useTextTheme: true,
    interactionEffects: true,
    inputDecoratorIsFilled: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    inputDecorationRadius: 48,
    blendOnColors: true,
    blendTextTheme: true,
    popupMenuOpacity: 0.95,
  ),
);

final darkTheme = FlexThemeData.dark(
  colors: const FlexSchemeColor(
    primary: Color(0xff8B5CF6),
    primaryVariant: Color(0xff4C1D95),
    secondary: Color(0xff34D399),
    secondaryVariant: Color(0xff34D399),
    appBarColor: Color(0xff34D399),
    error: Color(0xffE11D48),
  ),
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 21,
  tooltipsMatchBackground: true,
  swapColors: false,
  darkIsTrueBlack: false,
  useSubThemes: true,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  fontFamily: GoogleFonts.titilliumWeb().fontFamily,
  subThemesData: const FlexSubThemesData(
    useTextTheme: true,
    interactionEffects: true,
    inputDecoratorIsFilled: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    inputDecorationRadius: 48,
    blendOnColors: true,
    blendTextTheme: true,
    popupMenuOpacity: 0.95,
  ),
);
