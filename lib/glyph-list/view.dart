import 'package:app/ads/widgets.dart';
import 'package:app/glyph-list/functions.dart';
import 'package:app/glyph-list/glyph-group-grid-view.dart';
import 'package:app/glyph-list/glyph-group-list-view.dart';
import 'package:app/glyphs/defines/glyph.dart';
import 'package:app/math.dart';
import 'package:app/search/data-controller.dart';
import 'package:app/search/data-state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class EmojiListViewCreator extends StatelessWidget {
  const EmojiListViewCreator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchGlyphsDataController, SearchGlyphsDataState>(
      builder: (context, state) {
        return GlyphListView(
          groupedGlyphs: glyphsByGroup(state.filteredEmoji.toList()),
          groupBuilder: (context, glyphs) {
            return GlyphGroupGridView(glyphs: glyphs);
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
    return BlocBuilder<SearchGlyphsDataController, SearchGlyphsDataState>(
      builder: (context, state) {
        return GlyphListView(
          groupedGlyphs: glyphsByGroup(state.filteredSymbols.toList()),
          groupBuilder: (context, glyphs) {
            return GlyphGroupGridView(glyphs: glyphs);
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
    return BlocBuilder<SearchGlyphsDataController, SearchGlyphsDataState>(
      builder: (context, state) {
        return GlyphListView(
          groupedGlyphs: glyphsByGroup(state.filteredKaomoji.toList()),
          groupBuilder: (context, glyphs) {
            return GlyphGroupListView(glyphs: glyphs);
          },
        );
      },
    );
  }
}

class GlyphListView extends StatelessWidget {
  final Map<String, List<Glyph>> groupedGlyphs;
  final Widget Function(BuildContext, List<Glyph>) groupBuilder;

  const GlyphListView({
    super.key,
    required this.groupedGlyphs,
    required this.groupBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
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

class GlyphGroupTitleView extends StatelessWidget {
  final String title;

  const GlyphGroupTitleView({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 8),
        child: Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
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
