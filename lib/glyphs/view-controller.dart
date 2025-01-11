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

    final emoji = groupGlyphsByGroup(
      searchGlyphsDataController.state.filteredEmoji.toList(),
    );
    final symbols = groupGlyphsByGroup(
      searchGlyphsDataController.state.filteredSymbols.toList(),
    );
    final kaomoji = groupGlyphsByGroup(
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

  List<GlyphGroupViewState> groupGlyphsByGroup(List<Glyph> glyphs) {
    final groupMap = <String, List<Glyph>>{};
    for (final glyph in glyphs) {
      groupMap.update(
        glyph.group,
        ifAbsent: () => [glyph],
        (value) => value..add(glyph),
      );
    }
    return groupMap.entries.map((entry) {
      final adType = selectRandomAdType(
        includeNone: true,
      );
      return GlyphGroupViewState(
        title: entry.key,
        glyphs: entry.value.toIList(),
        ad: adType,
      );
    }).toList();
  }
}
