import 'package:app/glyph-data/data-state.dart';
import 'package:app/glyph-data/functions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphsDataController extends Cubit<GlyphsDataState> {
  factory GlyphsDataController.fromContext(BuildContext context) {
    return GlyphsDataController();
  }

  GlyphsDataController() : super(GlyphsDataState.initial()) {
    _init();
  }

  Future<void> _init() async {
    final emoji = await loadEmoji();
    final symbols = await loadSymbols();
    final kaomoji = await loadKaomoji();

    // Build unified map for fast lookups
    final allGlyphsMap = IMap.fromEntries([
      ...emoji.map((glyph) => MapEntry(glyph.glyph, glyph)),
      ...symbols.map((glyph) => MapEntry(glyph.glyph, glyph)),
      ...kaomoji.map((glyph) => MapEntry(glyph.glyph, glyph)),
    ]);

    emit(
      GlyphsDataState(
        emoji: emoji.toIList(),
        symbols: symbols.toIList(),
        kaomoji: kaomoji.toIList(),
        allGlyphsMap: allGlyphsMap,
      ),
    );
  }
}
