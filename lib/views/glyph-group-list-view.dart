import 'package:app/data/glyphs.dart';
import 'package:app/views/glyph-view.dart';
import 'package:flutter/material.dart';

class GlyphGroupListView extends StatelessWidget {
  final List<Glyph> glyphs;

  const GlyphGroupListView({
    Key? key,
    required this.glyphs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(24),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 56,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final glyph = glyphs.elementAt(index);
            return GlyphView(glyph: glyph);
          },
          childCount: glyphs.length,
        ),
      ),
    );
  }
}
