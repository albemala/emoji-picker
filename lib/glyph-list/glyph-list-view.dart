import 'package:app/ads/widgets.dart';
import 'package:app/glyph-list/functions.dart';
import 'package:app/glyph-list/glyph-group-grid-view.dart';
import 'package:app/glyph-list/glyph-group-list-view.dart';
import 'package:app/glyph-list/glyph-group-title-view.dart';
import 'package:app/glyphs/defines/glyph.dart';
import 'package:app/math.dart';
import 'package:app/search/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class EmojiListViewCreator extends StatelessWidget {
  const EmojiListViewCreator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchGlyphsBloc, SearchGlyphsState>(
      builder: (context, state) {
        return GroupedGlyphsView(
          groupedGlyphs: glyphsByGroup(state.filteredEmoji),
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
    return BlocBuilder<SearchGlyphsBloc, SearchGlyphsState>(
      builder: (context, state) {
        return GroupedGlyphsView(
          groupedGlyphs: glyphsByGroup(state.filteredSymbols),
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
    return BlocBuilder<SearchGlyphsBloc, SearchGlyphsState>(
      builder: (context, state) {
        return GroupedGlyphsView(
          groupedGlyphs: glyphsByGroup(state.filteredKaomoji),
          groupBuilder: (context, glyphs) {
            return GlyphGroupListView(glyphs: glyphs);
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
