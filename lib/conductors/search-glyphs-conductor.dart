import 'package:app/conductors/glyphs-conductor.dart';
import 'package:app/functions/glyphs.dart';
import 'package:app/models/glyph.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_state_management/flutter_state_management.dart';

class SearchGlyphsConductor extends Conductor {
  factory SearchGlyphsConductor.fromContext(BuildContext context) {
    return SearchGlyphsConductor(
      context.getConductor<GlyphsConductor>(),
    );
  }

  final GlyphsConductor _glyphsConductor;

  final searchFocusNode = FocusNode();

  final searchQueryController = TextEditingController();

  final filteredEmoji = ValueNotifier<Iterable<Glyph>>([]);

  final filteredSymbols = ValueNotifier<Iterable<Glyph>>([]);
  final filteredKaomoji = ValueNotifier<Iterable<Glyph>>([]);

  SearchGlyphsConductor(this._glyphsConductor) {
    _init();
  }

  void _init() {
    _glyphsConductor.emoji.addListener(_updateFilteredGlyphs);
    _glyphsConductor.symbols.addListener(_updateFilteredGlyphs);
    _glyphsConductor.kaomoji.addListener(_updateFilteredGlyphs);

    searchFocusNode.addListener(onSearchFocusChanged);
    searchQueryController.addListener(onSearchChanged);
  }

  @override
  void dispose() {
    _glyphsConductor.emoji.removeListener(_updateFilteredGlyphs);
    _glyphsConductor.symbols.removeListener(_updateFilteredGlyphs);
    _glyphsConductor.kaomoji.removeListener(_updateFilteredGlyphs);

    searchFocusNode.removeListener(onSearchFocusChanged);
    searchQueryController.removeListener(onSearchChanged);

    searchFocusNode.dispose();
    searchQueryController.dispose();
    filteredEmoji.dispose();
    filteredSymbols.dispose();
    filteredKaomoji.dispose();
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

  void onSearchChanged() {
    EasyDebounce.debounce(
      'search-debounce',
      const Duration(milliseconds: 300),
      _updateFilteredGlyphs,
    );
  }

  void _updateFilteredGlyphs() {
    if (searchQueryController.text.isEmpty) {
      filteredEmoji.value = _glyphsConductor.emoji.value;
      filteredSymbols.value = _glyphsConductor.symbols.value;
      filteredKaomoji.value = _glyphsConductor.kaomoji.value;
    } else {
      filteredEmoji.value = _glyphsConductor.emoji.value.where(
        (glyph) => matchesSearchTerm(
          glyph,
          searchQueryController.text,
        ),
      );
      filteredSymbols.value = _glyphsConductor.symbols.value.where(
        (glyph) => matchesSearchTerm(
          glyph,
          searchQueryController.text,
        ),
      );
      filteredKaomoji.value = _glyphsConductor.kaomoji.value.where(
        (glyph) => matchesSearchTerm(
          glyph,
          searchQueryController.text,
        ),
      );
    }
  }

  void clearSearch() {
    searchQueryController.clear();
  }
}
