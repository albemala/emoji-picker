import 'package:app/data/glyphs.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VisibleGlyphsBloc extends StateNotifier<Map<String, List<Glyph>>> {
  VisibleGlyphsBloc() : super(glyphsByGroup(glyphs));

  void onSearchChanged(String searchTerm) {
    if (searchTerm.isEmpty) {
      clearSearch();
    } else {
      final visibleGlyphs = glyphs.where((glyph) {
        return glyph.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
            weightedRatio(glyph.name, searchTerm) > 80;
        // return ratio(glyph.name, searchTerm) > 70;
        // return partialRatio(glyph.name, searchTerm) > 70;
      }).toList();
      state = glyphsByGroup(visibleGlyphs);
    }
  }

  void clearSearch() {
    state = glyphsByGroup(glyphs);
  }
}
