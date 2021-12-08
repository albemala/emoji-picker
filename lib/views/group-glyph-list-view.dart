import 'package:app/data/glyphs.dart';
import 'package:app/views/glyph-view.dart';
import 'package:flutter/material.dart';

class GroupGlyphListView extends StatelessWidget {
  final List<Glyph> glyphs;

  const GroupGlyphListView({
    Key? key,
    required this.glyphs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      itemCount: glyphs.length,
      itemBuilder: (context, index) {
        final glyph = glyphs.elementAt(index);
        return GlyphView(glyph: glyph);
      },
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 56,
        childAspectRatio: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
    );
  }
}
