import 'package:app/clipboard.dart';
import 'package:app/glyph-details/view-state.dart';
import 'package:app/glyphs/glyph.dart';
import 'package:app/routing.dart';
import 'package:app/widgets/snack-bar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphDetailsBloc extends Cubit<GlyphDetailsState> {
  Glyph? _selectedGlyph;

  factory GlyphDetailsBloc.fromContext(BuildContext context) {
    return GlyphDetailsBloc();
  }

  GlyphDetailsBloc()
      : super(
          const GlyphDetailsState(
            selectedGlyph: null,
            isGlyphDetailsVisible: false,
          ),
        );

  void showDetailsForGlyph(Glyph? glyph) {
    _selectedGlyph = glyph;
    _updateState();
  }

  void hideDetails() {
    _selectedGlyph = null;
    _updateState();
  }

  void _updateState() {
    emit(
      GlyphDetailsState(
        selectedGlyph: _selectedGlyph,
        isGlyphDetailsVisible: _selectedGlyph != null,
      ),
    );
  }

  Future<void> copySelectedGlyphToClipboard(BuildContext context) async {
    if (_selectedGlyph == null) return;
    await copyGlyphToClipboard(
      context,
      _selectedGlyph!,
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
