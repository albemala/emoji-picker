import 'package:app/blocs/app-info-bloc.dart';
import 'package:app/blocs/glyph-details-bloc.dart';
import 'package:app/blocs/theme-bloc.dart';
import 'package:app/blocs/urls-bloc.dart';
import 'package:app/blocs/visible-glyphs-bloc.dart';
import 'package:app/data/glyphs.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final visibleGlyphsProvider = StateNotifierProvider<VisibleGlyphsBloc, Map<String, List<Glyph>>>((_) {
  return VisibleGlyphsBloc();
});
final glyphDetailsProvider = StateNotifierProvider<GlyphDetailsBloc, Glyph?>((_) {
  return GlyphDetailsBloc();
});
final themeProvider = StateNotifierProvider<ThemeBloc, ThemeMode>((_) {
  return ThemeBloc();
});
final urlsProvider = Provider((_) {
  return UrlsBloc();
});
final appInfoProvider = Provider((_) {
  return AppInfoBloc();
});
