import 'package:app/glyphs/data-state.dart';
import 'package:app/glyphs/load-data.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
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
    final emoji = await loadEmoji();
    final symbols = await loadSymbols();
    final kaomoji = await loadKaomoji();
    emit(
      GlyphsDataState(
        emoji: emoji.toIList(),
        symbols: symbols.toIList(),
        kaomoji: kaomoji.toIList(),
      ),
    );
  }
}
