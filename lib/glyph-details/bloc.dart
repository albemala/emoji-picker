import 'package:app/clipboard.dart';
import 'package:app/glyphs/glyph.dart';
import 'package:app/routing/functions.dart';
import 'package:app/widgets/snack-bar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphDetailsState extends Equatable {
  final Glyph? selectedGlyph;
  final bool isGlyphDetailsVisible;

  const GlyphDetailsState({
    required this.selectedGlyph,
    required this.isGlyphDetailsVisible,
  });

  @override
  List<Object?> get props => [
        selectedGlyph,
        isGlyphDetailsVisible,
      ];
}

class GlyphDetailsBloc extends Cubit<GlyphDetailsState> {
  factory GlyphDetailsBloc.fromContext(BuildContext context) {
    return GlyphDetailsBloc();
  }

  Glyph? _selectedGlyph;

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
