import 'package:app/glyph-data/defines/glyph.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _scheme = FlexScheme.material;
const _variant = FlexSchemeVariant.vivid;
const _keyColors = FlexKeyColors(
    // useSecondary: true,
    // useTertiary: true,
    // useError: true,
    );

const _visualDensity = VisualDensity.compact;

final _fontFamily = GoogleFonts.titilliumWeb().fontFamily;

const _radius = 32.0;
const _subThemesData = FlexSubThemesData(
  defaultRadius: _radius,
  interactionEffects: true,
  tintedDisabledControls: true,
  inputDecoratorIsFilled: true,
  inputDecoratorBorderType: FlexInputBorderType.outline,
  alignedDropdown: true,
);

ThemeData getLightTheme() {
  return _applyThemeDefaults(
    FlexThemeData.light(
      scheme: _scheme,
      keyColors: _keyColors,
      variant: _variant,
      subThemesData: _subThemesData,
      visualDensity: _visualDensity,
      fontFamily: _fontFamily,
    ),
  );
}

ThemeData getDarkTheme() {
  return _applyThemeDefaults(
    FlexThemeData.dark(
      scheme: _scheme,
      keyColors: _keyColors,
      variant: _variant,
      subThemesData: _subThemesData,
      visualDensity: _visualDensity,
      fontFamily: _fontFamily,
    ),
  );
}

ThemeData _applyThemeDefaults(ThemeData themeData) {
  return themeData.copyWith();
}

TextStyle getTextStyleForGlyph(Glyph glyph) {
  switch (glyph.type) {
    case GlyphType.emoji:
      return TextStyle(
        fontFamilyFallback: [
          'Apple Color Emoji', // iOS and macOS
          'Segoe UI Emoji', // Windows
          'Android Emoji', // Android
          GoogleFonts.notoColorEmoji().fontFamily ?? '', // Web
        ],
      );
    case GlyphType.symbol:
      return const TextStyle(
        fontFamily: 'Noto Sans Living',
        fontFamilyFallback: [
          'Noto Sans Japanese',
          'Noto Sans Korean',
          'Noto Sans Simplified Chinese',
        ],
      );
    case GlyphType.kaomoji:
      return const TextStyle(
        fontFamily: 'Noto Sans Living',
        fontFamilyFallback: [
          'Noto Sans Japanese',
          'Noto Sans Korean',
          'Noto Sans Simplified Chinese',
        ],
      );
    case GlyphType.unknown:
      return const TextStyle();
  }
}
