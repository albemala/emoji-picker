import 'package:app/models/glyph.dart';
import 'package:app/views/glyph.dart';
import 'package:flutter/material.dart';

class GlyphGroupListView extends StatelessWidget {
  final List<Glyph> glyphs;

  const GlyphGroupListView({
    super.key,
    required this.glyphs,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: glyphs.length,
      itemBuilder: (context, index) {
        final glyph = glyphs.elementAt(index);
        return GlyphViewCreator(
          glyph: glyph,
          glyphContentBuilder: (BuildContext context, Glyph glyph) {
            return RectangularGlyphContentView(glyph: glyph);
          },
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
    );
  }
}
