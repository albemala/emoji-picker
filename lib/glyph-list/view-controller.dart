import 'package:app/glyph-details/view-controller.dart';
import 'package:app/glyph-list/view-state.dart';
import 'package:app/glyphs/defines/glyph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphViewController extends Cubit<GlyphViewState> {
  final GlyphDetailsViewController _glyphDetailsViewcontroller;
  final focusNode = FocusNode();

  factory GlyphViewController.fromContext(BuildContext context) {
    return GlyphViewController(
      context.read<GlyphDetailsViewController>(),
    );
  }

  GlyphViewController(this._glyphDetailsViewcontroller)
      : super(defaultGlyphViewState);

  @override
  Future<void> close() async {
    focusNode.dispose();
    await super.close();
  }

  void onFocusChange(bool isFocused, Glyph glyph) {
    if (isFocused) {
      _glyphDetailsViewcontroller.showDetailsForGlyph(glyph);
    } else {
      _glyphDetailsViewcontroller.hideDetails();
    }
  }

  void copyGlyphToClipboard(BuildContext context, Glyph glyph) {
    _glyphDetailsViewcontroller.copyGlyphToClipboard(context, glyph);
  }
}
