import 'package:app/data/glyphs.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilteredGlyphsBloc extends StateNotifier<Map<String, List<Glyph>>> {
  FilteredGlyphsBloc() : super(glyphsByGroup(glyphs));

  void onSearchChanged(String searchTerm) {
    EasyDebounce.debounce(
      'search-debounce',
      const Duration(milliseconds: 300),
      () => _updateFilteredGlyphs(searchTerm),
    );
  }

  void _updateFilteredGlyphs(String searchTerm) {
    if (searchTerm.isEmpty) {
      state = glyphsByGroup(glyphs);
    } else {
      final filteredGlyphs = glyphs
          .where((glyph) => _matchesSearchTerm(glyph, searchTerm))
          .toList();
      state = glyphsByGroup(filteredGlyphs);
    }
  }

  bool _matchesSearchTerm(Glyph glyph, String searchTerm) {
    return _nameMatchesSearchTerm(glyph, searchTerm) ||
        _keywordsMatchesSearchTerm(glyph, searchTerm);
  }

  bool _nameMatchesSearchTerm(Glyph glyph, String searchTerm) {
    final lowerCaseName = glyph.name.toLowerCase();
    final lowerCaseSearchTerm = searchTerm.toLowerCase();
    final nameContainsSearchTerm = lowerCaseName.contains(lowerCaseSearchTerm);
    final nameMatchesSearchTerm = weightedRatio(glyph.name, searchTerm) > 80;
    return nameContainsSearchTerm || nameMatchesSearchTerm;
  }

  bool _keywordsMatchesSearchTerm(Glyph glyph, String searchTerm) {
    final lowerCaseSearchTerm = searchTerm.toLowerCase();
    final keywordsContainsSearchTerm = glyph.keywords.any(
      (keyword) => keyword.toLowerCase().contains(lowerCaseSearchTerm),
    );
    final keywordsMatchesSearchTerm = glyph.keywords.any(
      (keyword) => weightedRatio(keyword, searchTerm) > 80,
    );
    return keywordsContainsSearchTerm || keywordsMatchesSearchTerm;
  }

  void clearSearch() {
    state = glyphsByGroup(glyphs);
  }
}
