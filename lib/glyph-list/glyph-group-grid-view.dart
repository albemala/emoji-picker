import 'package:app/glyph-list/view.dart';
import 'package:app/glyphs/defines/glyph.dart';
import 'package:flutter/material.dart';

class GlyphGroupGridView extends StatelessWidget {
  final List<Glyph> glyphs;

  const GlyphGroupGridView({
    super.key,
    required this.glyphs,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 56,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final glyph = glyphs.elementAt(index);
          return GlyphViewCreator(
            glyph: glyph,
            glyphContentBuilder: (BuildContext context, Glyph glyph) {
              return SquaredGlyphContentView(glyph: glyph);
            },
          );
        },
        childCount: glyphs.length,
      ),
    );
  }
}
