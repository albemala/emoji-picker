import 'package:app/models/glyph.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_state_management/flutter_state_management.dart';

class GlyphDetailsConductor extends Conductor {
  factory GlyphDetailsConductor.fromContext(BuildContext context) {
    return GlyphDetailsConductor();
  }

  final selectedGlyph = ValueNotifier<Glyph?>(null);

  final isGlyphDetailsVisible = ValueNotifier<bool>(false);

  GlyphDetailsConductor() {
    selectedGlyph.addListener(updateIsGlyphDetailsVisible);
  }

  @override
  void dispose() {
    selectedGlyph.removeListener(updateIsGlyphDetailsVisible);

    selectedGlyph.dispose();
    isGlyphDetailsVisible.dispose();
  }

  void showDetailsForGlyph(Glyph? glyph) {
    selectedGlyph.value = glyph;
  }

  void hideDetails() {
    selectedGlyph.value = null;
  }

  void updateIsGlyphDetailsVisible() {
    isGlyphDetailsVisible.value = selectedGlyph.value != null;
  }
}
