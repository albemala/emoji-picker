import 'package:app/glyphs/defines/glyph.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

bool matchesSearchTerm(Glyph glyph, String searchTerm) {
  return nameMatchesSearchTerm(glyph, searchTerm) ||
      keywordsMatchesSearchTerm(glyph, searchTerm);
}

bool nameMatchesSearchTerm(Glyph glyph, String searchTerm) {
  final lowerCaseName = glyph.name.toLowerCase();
  final lowerCaseSearchTerm = searchTerm.toLowerCase();
  final nameContainsSearchTerm = lowerCaseName.contains(lowerCaseSearchTerm);
  final nameMatchesSearchTerm = weightedRatio(glyph.name, searchTerm) > 80;
  return nameContainsSearchTerm || nameMatchesSearchTerm;
}

bool keywordsMatchesSearchTerm(Glyph glyph, String searchTerm) {
  final lowerCaseSearchTerm = searchTerm.toLowerCase();
  final keywordsContainsSearchTerm = glyph.keywords.any(
    (keyword) => keyword.toLowerCase().contains(lowerCaseSearchTerm),
  );
  final keywordsMatchesSearchTerm = glyph.keywords.any(
    (keyword) => weightedRatio(keyword, searchTerm) > 80,
  );
  return keywordsContainsSearchTerm || keywordsMatchesSearchTerm;
}
