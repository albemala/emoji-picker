import 'package:app/glyph-details/view_controller.dart';
import 'package:app/glyph-list/view_state.dart';
import 'package:app/glyphs/glyph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphViewBloc extends Cubit<GlyphViewModel> {
  final GlyphDetailsBloc _glyphDetailsBloc;
  final focusNode = FocusNode();

  factory GlyphViewBloc.fromContext(BuildContext context) {
    return GlyphViewBloc(
      context.read<GlyphDetailsBloc>(),
    );
  }

  GlyphViewBloc(this._glyphDetailsBloc)
      : super(
          const GlyphViewModel(),
        );

  @override
  Future<void> close() async {
    focusNode.dispose();
    await super.close();
  }

  void onFocusChange(bool isFocused, Glyph glyph) {
    if (isFocused) {
      _glyphDetailsBloc.showDetailsForGlyph(glyph);
    } else {
      _glyphDetailsBloc.hideDetails();
    }
  }

  void copyGlyphToClipboard(BuildContext context, Glyph glyph) {
    _glyphDetailsBloc.copyGlyphToClipboard(context, glyph);
  }
}
