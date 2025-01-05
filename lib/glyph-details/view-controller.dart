import 'package:app/clipboard.dart';
import 'package:app/glyph-details/view-state.dart';
import 'package:app/glyphs/defines/glyph.dart';
import 'package:app/routing.dart';
import 'package:app/widgets/snack-bar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphDetailsViewController extends Cubit<GlyphDetailsViewState> {
  var _selectedGlyph = unknownGlyph;

  factory GlyphDetailsViewController.fromContext(BuildContext context) {
    return GlyphDetailsViewController();
  }

  GlyphDetailsViewController() : super(defaultGlyphDetailsViewState);

  void showDetailsForGlyph(Glyph glyph) {
    _selectedGlyph = glyph;
    _updateState();
  }

  void hideDetails() {
    _selectedGlyph = unknownGlyph;
    _updateState();
  }

  void _updateState() {
    emit(
      GlyphDetailsViewState(
        selectedGlyph: _selectedGlyph,
        isGlyphDetailsVisible: _selectedGlyph != unknownGlyph,
      ),
    );
  }

  Future<void> copySelectedGlyphToClipboard(BuildContext context) async {
    if (_selectedGlyph == unknownGlyph) return;
    await copyGlyphToClipboard(
      context,
      _selectedGlyph,
    );
  }

  Future<void> copyGlyphToClipboard(
    BuildContext context,
    Glyph glyph,
  ) async {
    await copyToClipboard(glyph.glyph);
    showSnackBar(
      context,
      createCopiedToClipboardSnackBar(glyph.glyph),
    );
  }

  Future<void> copyGlyphUnicodeToClipboard(
    BuildContext context,
    Glyph glyph,
  ) async {
    await copyToClipboard(glyph.unicode);
    showSnackBar(
      context,
      createCopiedToClipboardSnackBar(glyph.unicode),
    );
  }

  Future<void> copyGlyphHtmlCodeToClipboard(
    BuildContext context,
    Glyph glyph,
  ) async {
    await copyToClipboard(glyph.htmlCode);
    showSnackBar(
      context,
      createCopiedToClipboardSnackBar(glyph.htmlCode),
    );
  }
}
