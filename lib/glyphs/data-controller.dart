import 'package:app/glyphs/data-state.dart';
import 'package:app/glyphs/load-data.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphsDataController extends Cubit<GlyphsDataState> {
  factory GlyphsDataController.fromContext(BuildContext context) {
    return GlyphsDataController();
  }

  GlyphsDataController() : super(defaultGlyphsDataState) {
    _init();
  }

  Future<void> _init() async {
    emit(
      GlyphsDataState(
        emoji: await loadEmoji(),
        symbols: await loadSymbols(),
        kaomoji: await loadKaomoji(),
      ),
    );
  }
}
