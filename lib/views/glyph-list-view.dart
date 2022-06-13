import 'package:app/providers.dart';
import 'package:app/views/glyph-group-list-view.dart';
import 'package:app/views/glyph-group-title-view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

class GlyphListView extends HookConsumerWidget {
  const GlyphListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visibleGlyphs = ref.watch(visibleGlyphsProvider);
    return CustomScrollView(
      slivers: visibleGlyphs.entries.map((entry) {
        return MultiSliver(
          children: [
            GlyphGroupTitleView(title: entry.key),
            GlyphGroupListView(glyphs: entry.value),
          ],
        );
      }).toList(),
    );
  }
}
