import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/selected-glyph/data-state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedGlyphDataController extends Cubit<SelectedGlyphDataState> {
  factory SelectedGlyphDataController.fromContext(BuildContext context) {
    return SelectedGlyphDataController();
  }

  SelectedGlyphDataController() : super(defaultSelectedGlyphDataState);

  Glyph get selectedGlyph => state.selectedGlyph;
  set selectedGlyph(Glyph value) => emit(state.copyWith(selectedGlyph: value));
}
