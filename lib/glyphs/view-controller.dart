import 'dart:async';

import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyphs/view-state.dart';
import 'package:app/search/data-controller.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphsViewController extends Cubit<GlyphsViewState> {
  final SearchGlyphsDataController searchGlyphsDataController;

  StreamSubscription<void>? searchGlyphsDataControllerSubscription;

  factory GlyphsViewController.fromContext(BuildContext context) {
    return GlyphsViewController(context.read<SearchGlyphsDataController>());
  }

  GlyphsViewController(this.searchGlyphsDataController)
    : super(defaultGlyphsViewState) {
    searchGlyphsDataControllerSubscription = searchGlyphsDataController.stream
        .listen((_) {
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
    final favorites = groupFavoriteGlyphsByType(
      searchGlyphsDataController.state.filteredFavorites.toList(),
    );
    emit(
      state.copyWith(
        emoji: emoji.toIList(),
        symbols: symbols.toIList(),
        kaomoji: kaomoji.toIList(),
        favorites: favorites.toIList(),
      ),
    );
  }

  List<GlyphGroupViewState> groupGlyphs(List<Glyph> glyphs) {
    final groups = <String, GlyphGroupViewState>{};
    for (final glyph in glyphs) {
      groups.update(
        glyph.group,
        (existing) {
          return existing.copyWith(glyphs: existing.glyphs.add(glyph));
        },
        ifAbsent: () {
          return GlyphGroupViewState(
            title: glyph.group,
            glyphs: IList([glyph]),
          );
        },
      );
    }
    return groups.values.toList();
  }

  List<GlyphGroupViewState> groupFavoriteGlyphsByType(List<Glyph> glyphs) {
    final emoji = <Glyph>[];
    final symbols = <Glyph>[];
    final kaomoji = <Glyph>[];

    for (final glyph in glyphs) {
      switch (glyph.type) {
        case GlyphType.emoji:
          emoji.add(glyph);
        case GlyphType.symbol:
          symbols.add(glyph);
        case GlyphType.kaomoji:
          kaomoji.add(glyph);
        case GlyphType.unknown:
          throw UnimplementedError();
      }
    }

    return [
      if (emoji.isNotEmpty)
        GlyphGroupViewState(title: 'Emoji', glyphs: emoji.toIList()),
      if (symbols.isNotEmpty)
        GlyphGroupViewState(title: 'Symbols', glyphs: symbols.toIList()),
      if (kaomoji.isNotEmpty)
        GlyphGroupViewState(title: 'Kaomoji', glyphs: kaomoji.toIList()),
    ];
  }
}
