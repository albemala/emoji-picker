import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const FlexScheme _scheme = FlexScheme.material;
const FlexSchemeVariant _lightVariant = FlexSchemeVariant.candyPop;
const FlexSchemeVariant _darkVariant = FlexSchemeVariant.highContrast;
const _keyColors = FlexKeyColors(
  useSecondary: true,
  // useTertiary: true,
  // useError: true,
);

const VisualDensity _visualDensity = VisualDensity.compact;

final String? _fontFamily = GoogleFonts.titilliumWeb().fontFamily;

const _subThemesData = FlexSubThemesData(
  defaultRadius: 32,
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
      variant: _lightVariant,
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
      variant: _darkVariant,
      subThemesData: _subThemesData,
      visualDensity: _visualDensity,
      fontFamily: _fontFamily,
    ),
  );
}

ThemeData _applyThemeDefaults(ThemeData themeData) {
  return themeData.copyWith();
}
