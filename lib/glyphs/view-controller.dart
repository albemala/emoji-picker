import 'dart:async';

import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyphs/view-state.dart';
import 'package:app/math.dart';
import 'package:app/search/data-controller.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphsViewController extends Cubit<GlyphsViewState> {
  final SearchGlyphsDataController _searchGlyphsDataController;
  StreamSubscription<void>? _searchGlyphsDataControllerSubscription;

  factory GlyphsViewController.fromContext(BuildContext context) {
    return GlyphsViewController(
      context.read<SearchGlyphsDataController>(),
    );
  }

  GlyphsViewController(
    this._searchGlyphsDataController,
  ) : super(defaultGlyphsViewState) {
    _searchGlyphsDataControllerSubscription =
        _searchGlyphsDataController.stream.listen((_) {
      updateViewState();
    });
    updateViewState();
  }

  @override
  Future<void> close() async {
    await _searchGlyphsDataControllerSubscription?.cancel();
    return super.close();
  }

  void updateViewState() {
    if (isClosed) return;

    final emoji = groupGlyphsByGroup(
      _searchGlyphsDataController.state.filteredEmoji.toList(),
    );
    final symbols = groupGlyphsByGroup(
      _searchGlyphsDataController.state.filteredSymbols.toList(),
    );
    final kaomoji = groupGlyphsByGroup(
      _searchGlyphsDataController.state.filteredKaomoji.toList(),
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
      return GlyphGroupViewState(
        title: entry.key,
        glyphs: entry.value.toIList(),
        ad: selectAdType(),
      );
    }).toList();
  }

  AdType selectAdType() {
    final index = randomInt(0, AdType.values.length + 3);
    if (index >= 0 && index < AdType.values.length - 1) {
      return AdType.values[index];
    }
    return AdType.none;
  }
}
