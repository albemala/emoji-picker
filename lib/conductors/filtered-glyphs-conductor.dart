import 'package:app/conductors/glyphs-conductor.dart';
import 'package:app/functions/glyphs.dart';
import 'package:app/models/glyph.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_state_management/flutter_state_management.dart';

class FilteredGlyphsConductor extends Conductor {
  factory FilteredGlyphsConductor.fromContext(BuildContext context) {
    return FilteredGlyphsConductor(
      context.getConductor<GlyphsConductor>(),
    );
  }

  final GlyphsConductor _glyphsConductor;

  final searchFocusNode = FocusNode();

  final searchQueryController = TextEditingController();

  final filteredGlyphs = ValueNotifier<Map<String, List<Glyph>>>({});

  FilteredGlyphsConductor(this._glyphsConductor) {
    _init();
  }

  void _init() {
    _glyphsConductor.glyphs.addListener(_updateFilteredGlyphs);
    searchFocusNode.addListener(onSearchFocusChanged);
    searchQueryController.addListener(onSearchChanged);
  }

  @override
  void dispose() {
    _glyphsConductor.glyphs.removeListener(_updateFilteredGlyphs);
    searchFocusNode.removeListener(onSearchFocusChanged);
    searchQueryController.removeListener(onSearchChanged);

    searchFocusNode.dispose();
    searchQueryController.dispose();
    filteredGlyphs.dispose();
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
      filteredGlyphs.value = glyphsByGroup(_glyphsConductor.glyphs.value);
    } else {
      final filteredGlyphs = _glyphsConductor.glyphs.value
          .where(
            (glyph) => matchesSearchTerm(
              glyph,
              searchQueryController.text,
            ),
          )
          .toList();
      this.filteredGlyphs.value = glyphsByGroup(filteredGlyphs);
    }
  }

  void clearSearch() {
    searchQueryController.clear();
  }
}
