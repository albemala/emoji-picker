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
