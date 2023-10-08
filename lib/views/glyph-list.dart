import 'package:app/conductors/search-glyphs-conductor.dart';
import 'package:app/functions/glyphs.dart';
import 'package:app/functions/math.dart';
import 'package:app/models/glyph.dart';
import 'package:app/views/ads.dart';
import 'package:app/views/glyph-group-grid.dart';
import 'package:app/views/glyph-group-list.dart';
import 'package:app/views/glyph-group-title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_management/flutter_state_management.dart';
import 'package:sliver_tools/sliver_tools.dart';

class EmojiListViewCreator extends StatelessWidget {
  const EmojiListViewCreator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConductorConsumer<SearchGlyphsConductor>(
      builder: (context, conductor) {
        return ValueListenableBuilder(
          valueListenable: conductor.filteredEmoji,
          builder: (context, filteredEmoji, _) {
            return GroupedGlyphsView(
              groupedGlyphs: glyphsByGroup(filteredEmoji),
              groupBuilder: (context, glyphs) {
                return GlyphGroupGridView(glyphs: glyphs);
              },
            );
          },
        );
      },
    );
  }
}

class SymbolListViewCreator extends StatelessWidget {
  const SymbolListViewCreator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConductorConsumer<SearchGlyphsConductor>(
      builder: (context, conductor) {
        return ValueListenableBuilder(
          valueListenable: conductor.filteredSymbols,
          builder: (context, filteredSymbols, _) {
            return GroupedGlyphsView(
              groupedGlyphs: glyphsByGroup(filteredSymbols),
              groupBuilder: (context, glyphs) {
                return GlyphGroupGridView(glyphs: glyphs);
              },
            );
          },
        );
      },
    );
  }
}

class KaomojiListViewCreator extends StatelessWidget {
  const KaomojiListViewCreator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConductorConsumer<SearchGlyphsConductor>(
      builder: (context, conductor) {
        return ValueListenableBuilder(
          valueListenable: conductor.filteredKaomoji,
          builder: (context, filteredKaomoji, _) {
            return GroupedGlyphsView(
              groupedGlyphs: glyphsByGroup(filteredKaomoji),
              groupBuilder: (context, glyphs) {
                return GlyphGroupListView(glyphs: glyphs);
              },
            );
          },
        );
      },
    );
  }
}

class GroupedGlyphsView extends StatelessWidget {
  final Map<String, List<Glyph>> groupedGlyphs;
  final Widget Function(BuildContext, List<Glyph>) groupBuilder;

  const GroupedGlyphsView({
    super.key,
    required this.groupedGlyphs,
    required this.groupBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: CustomScrollView(
        slivers: groupedGlyphs.entries.map((entry) {
          return MultiSliver(
            pushPinnedChildren: true,
            children: [
              SliverPinnedHeader(
                child: GlyphGroupTitleView(title: entry.key),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(21),
                sliver: groupBuilder(context, entry.value),
              ),
              const _AdView(),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _AdView extends StatelessWidget {
  const _AdView();

  @override
  Widget build(BuildContext context) {
    // randomize which ad to show
    final number = randomInt(1, 120);
    if (isBetween(number, 1, 3)) {
      return const _AdContainerView(
        child: ExaboxAdView(),
      );
    }
    if (isBetween(number, 11, 13)) {
      return const _AdContainerView(
        child: HexeeProAdView(),
      );
    }
    if (isBetween(number, 21, 23)) {
      return const _AdContainerView(
        child: WMapAdView(),
      );
    }
    if (isBetween(number, 31, 33)) {
      return const _AdContainerView(
        child: IroIronAdView(),
      );
    }
    return const SizedBox();
  }
}

class _AdContainerView extends StatelessWidget {
  final Widget child;

  const _AdContainerView({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 3,
          child: Material(),
        ),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(21),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
