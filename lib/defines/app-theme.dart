import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = FlexThemeData.light(
  scheme: FlexScheme.material,
  subThemesData: const FlexSubThemesData(
    defaultRadius: 32,
  ),
  blendLevel: 8,
  useMaterial3: true,
  fontFamily: GoogleFonts.titilliumWeb().fontFamily,
);

final darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.material,
  subThemesData: const FlexSubThemesData(
    defaultRadius: 32,
  ),
  blendLevel: 24,
  useMaterial3: true,
  fontFamily: GoogleFonts.titilliumWeb().fontFamily,
);
