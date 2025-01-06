import 'package:app/glyphs/defines/glyph.dart';
import 'package:app/selected-glyph/data-state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedGlyphDataController extends Cubit<SelectedGlyphDataState> {
  factory SelectedGlyphDataController.fromContext(BuildContext context) {
    return context.read<SelectedGlyphDataController>();
  }

  SelectedGlyphDataController() : super(defaultSelectedGlyphDataState);

  Glyph get selectedGlyph => state.selectedGlyph;
  set selectedGlyph(Glyph value) => emit(state.copyWith(selectedGlyph: value));
}
