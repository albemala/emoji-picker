import 'package:app/conductors/search-glyphs-conductor.dart';
import 'package:app/functions/glyphs.dart';
import 'package:app/functions/math.dart';
import 'package:app/models/glyph.dart';
import 'package:app/views/ads.dart';
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
            return GlyphListView(
              groupedGlyphs: glyphsByGroup(filteredEmoji),
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
            return GlyphListView(
              groupedGlyphs: glyphsByGroup(filteredSymbols),
            );
          },
        );
      },
    );
  }
}

class GlyphListView extends StatelessWidget {
  final Map<String, List<Glyph>> groupedGlyphs;

  const GlyphListView({
    super.key,
    required this.groupedGlyphs,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      elevation: Theme.of(context).brightness == Brightness.light ? 1 : 12,
      child: CustomScrollView(
        slivers: groupedGlyphs.entries.map((entry) {
          return MultiSliver(
            pushPinnedChildren: true,
            children: [
              SliverPinnedHeader(
                child: GlyphGroupTitleView(title: entry.key),
              ),
              GlyphGroupListView(glyphs: entry.value),
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
          height: 2,
          child: Material(),
        ),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
