import 'package:app/glyphs/defines/glyph.dart';

Map<String, List<Glyph>> glyphsByGroup(Iterable<Glyph> glyphs) {
  final map = <String, List<Glyph>>{};
  for (final glyph in glyphs) {
    map.update(
      glyph.group,
      ifAbsent: () => [glyph],
      (value) => value..add(glyph),
    );
  }
  return map;
}
