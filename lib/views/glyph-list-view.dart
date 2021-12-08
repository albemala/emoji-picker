import 'package:app/providers.dart';
import 'package:app/views/group-glyph-list-view.dart';
import 'package:app/views/group-title-view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GlyphListView extends HookConsumerWidget {
  const GlyphListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visibleGlyphs = ref.watch(visibleGlyphsProvider);
    return ListView.separated(
      padding: const EdgeInsets.all(24),
      // padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      itemCount: visibleGlyphs.keys.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GroupTitleView(title: visibleGlyphs.keys.elementAt(index)),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: GroupGlyphListView(
                glyphs: visibleGlyphs.values.elementAt(index),
              ),
            )
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 24),
    );
  }
}
