import 'dart:async';

import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyphs/view-state.dart';
import 'package:app/search/data-controller.dart';
import 'package:app/widgets/ads.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphsViewController extends Cubit<GlyphsViewState> {
  final SearchGlyphsDataController searchGlyphsDataController;
  StreamSubscription<void>? searchGlyphsDataControllerSubscription;

  factory GlyphsViewController.fromContext(BuildContext context) {
    return GlyphsViewController(
      context.read<SearchGlyphsDataController>(),
    );
  }

  GlyphsViewController(
    this.searchGlyphsDataController,
  ) : super(defaultGlyphsViewState) {
    searchGlyphsDataControllerSubscription =
        searchGlyphsDataController.stream.listen((_) {
      updateViewState();
    });
    updateViewState();
  }

  @override
  Future<void> close() {
    searchGlyphsDataControllerSubscription?.cancel();
    return super.close();
  }

  void updateViewState() {
    if (isClosed) return;

    final emoji = groupGlyphs(
      searchGlyphsDataController.state.filteredEmoji.toList(),
    );
    final symbols = groupGlyphs(
      searchGlyphsDataController.state.filteredSymbols.toList(),
    );
    final kaomoji = groupGlyphs(
      searchGlyphsDataController.state.filteredKaomoji.toList(),
    );
    emit(
      state.copyWith(
        emoji: emoji.toIList(),
        symbols: symbols.toIList(),
        kaomoji: kaomoji.toIList(),
      ),
    );
  }

  List<GlyphGroupViewState> groupGlyphs(List<Glyph> glyphs) {
    final groups = <String, GlyphGroupViewState>{};
    for (final glyph in glyphs) {
      groups.update(
        glyph.group,
        (existing) => existing.copyWith(
          glyphs: existing.glyphs.add(glyph),
        ),
        ifAbsent: () => GlyphGroupViewState(
          title: glyph.group,
          glyphs: IList([glyph]),
          ad: selectRandomAdType(includeNone: true),
        ),
      );
    }
    return groups.values.toList();
  }
}
