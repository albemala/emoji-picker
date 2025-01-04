import 'dart:async';

import 'package:app/glyphs/data-controller.dart';
import 'package:app/glyphs/data-state.dart';
import 'package:app/glyphs/defines/glyph.dart';
import 'package:app/glyphs/functions.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class SearchGlyphsState extends Equatable {
  final Iterable<Glyph> filteredEmoji;
  final Iterable<Glyph> filteredSymbols;
  final Iterable<Glyph> filteredKaomoji;

  const SearchGlyphsState({
    required this.filteredEmoji,
    required this.filteredSymbols,
    required this.filteredKaomoji,
  });

  @override
  List<Object?> get props => [
        filteredEmoji,
        filteredSymbols,
        filteredKaomoji,
      ];
}

class SearchGlyphsBloc extends Cubit<SearchGlyphsState> {
  final GlyphsDataController _glyphsBloc;
  StreamSubscription<GlyphsDataState>? _glyphsBlocSubscription;

  final searchFocusNode = FocusNode();
  final searchQueryController = TextEditingController();

  factory SearchGlyphsBloc.fromContext(BuildContext context) {
    return SearchGlyphsBloc(
      context.read<GlyphsDataController>(),
    );
  }

  SearchGlyphsBloc(
    this._glyphsBloc,
  ) : super(
          const SearchGlyphsState(
            filteredEmoji: [],
            filteredSymbols: [],
            filteredKaomoji: [],
          ),
        ) {
    _init();
  }

  void _init() {
    _glyphsBlocSubscription = _glyphsBloc.stream.listen((_) {
      _updateState();
    });
    _updateState();

    searchFocusNode.addListener(onSearchFocusChanged);
    searchQueryController.addListener(onSearchChanged);
  }

  @override
  Future<void> close() async {
    await _glyphsBlocSubscription?.cancel();

    searchFocusNode
      ..removeListener(onSearchFocusChanged)
      ..dispose();

    searchQueryController
      ..removeListener(onSearchChanged)
      ..dispose();

    await super.close();
  }

  void onSearchFocusChanged() {
    // When the search field gets focused, select the existing text
    if (searchFocusNode.hasFocus) {
      searchQueryController.value = searchQueryController.value.copyWith(
        selection: TextSelection(
          baseOffset: 0,
          extentOffset: searchQueryController.text.length,
        ),
        composing: TextRange.empty,
      );
    }
  }

  void setSearchQuery(String value) {
    searchQueryController.value = TextEditingValue(
      text: value,
      selection: searchQueryController.selection,
    );
  }

  void clearSearch() {
    searchQueryController.clear();
  }

  void onSearchChanged() {
    EasyDebounce.debounce(
      'search-debounce',
      const Duration(milliseconds: 300),
      _updateState,
    );
  }

  void _updateState() {
    final searchQuery = searchQueryController.text;
    final glyphsState = _glyphsBloc.state;
    final isSearchEmpty = searchQuery.isEmpty;
    bool test(Glyph glyph) => matchesSearchTerm(glyph, searchQuery);

    final filteredEmoji =
        isSearchEmpty ? glyphsState.emoji : glyphsState.emoji.where(test);
    final filteredSymbols =
        isSearchEmpty ? glyphsState.symbols : glyphsState.symbols.where(test);
    final filteredKaomoji =
        isSearchEmpty ? glyphsState.kaomoji : glyphsState.kaomoji.where(test);

    emit(
      SearchGlyphsState(
        filteredEmoji: filteredEmoji,
        filteredSymbols: filteredSymbols,
        filteredKaomoji: filteredKaomoji,
      ),
    );
  }
}
