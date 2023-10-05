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
    return SliverPadding(
      padding: const EdgeInsets.all(21),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 56,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final glyph = glyphs.elementAt(index);
            return GlyphViewCreator(glyph: glyph);
          },
          childCount: glyphs.length,
        ),
      ),
    );
  }
}
