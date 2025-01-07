import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyph-tile/view.dart';
import 'package:app/glyphs/view-controller.dart';
import 'package:app/glyphs/view-state.dart';
import 'package:app/widgets/ads.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class GlyphsViewCreator extends StatelessWidget {
  const GlyphsViewCreator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlyphsViewController>(
      create: GlyphsViewController.fromContext,
      child: BlocBuilder<GlyphsViewController, GlyphsViewState>(
        builder: (context, state) {
          return GlyphsView(
            controller: context.read<GlyphsViewController>(),
            state: state,
          );
        },
      ),
    );
  }
}

class GlyphsView extends StatelessWidget {
  final GlyphsViewController controller;
  final GlyphsViewState state;

  const GlyphsView({
    super.key,
    required this.controller,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return TabBar(
                isScrollable: constraints.maxWidth > 480,
                labelPadding: const EdgeInsets.symmetric(horizontal: 21),
                tabs: const [
                  Tab(text: 'Emoji'),
                  Tab(text: 'Symbols'),
                  Tab(text: 'Kaomoji'),
                ],
              );
            },
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _EmojiView(state: state),
                _SymbolsView(state: state),
                _KaomojiView(state: state),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmojiView extends StatelessWidget {
  final GlyphsViewState state;

  const _EmojiView({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return _GlyphGroupView(
      groups: state.emoji,
      groupBuilder: (context, glyphs) {
        return _GlyphGroupGridView(glyphs: glyphs);
      },
    );
  }
}

class _SymbolsView extends StatelessWidget {
  final GlyphsViewState state;

  const _SymbolsView({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return _GlyphGroupView(
      groups: state.symbols,
      groupBuilder: (context, glyphs) {
        return _GlyphGroupGridView(glyphs: glyphs);
      },
    );
  }
}

class _KaomojiView extends StatelessWidget {
  final GlyphsViewState state;

  const _KaomojiView({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return _GlyphGroupView(
      groups: state.kaomoji,
      groupBuilder: (context, glyphs) {
        return _GlyphGroupListView(glyphs: glyphs);
      },
    );
  }
}

class _GlyphGroupView extends StatelessWidget {
  final IList<GlyphGroupViewState> groups;
  final Widget Function(BuildContext, List<Glyph>) groupBuilder;

  const _GlyphGroupView({
    required this.groups,
    required this.groupBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: groups.map((group) {
        return MultiSliver(
          pushPinnedChildren: true,
          children: [
            SliverPinnedHeader(
              child: _GlyphGroupTitleView(title: group.title),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(21),
              sliver: groupBuilder(context, group.glyphs.toList()),
            ),
            _AdView(
              adType: group.ad,
            ),
          ],
        );
      }).toList(),
    );
  }
}

class _GlyphGroupTitleView extends StatelessWidget {
  final String title;

  const _GlyphGroupTitleView({
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

class _GlyphGroupGridView extends StatelessWidget {
  final List<Glyph> glyphs;

  const _GlyphGroupGridView({
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
          return GlyphTileViewCreator(
            glyph: glyph,
            glyphContentBuilder: (BuildContext context, Glyph glyph) {
              return SquaredGlyphTileContentView(glyph: glyph);
            },
          );
        },
        childCount: glyphs.length,
      ),
    );
  }
}

class _GlyphGroupListView extends StatelessWidget {
  final List<Glyph> glyphs;

  const _GlyphGroupListView({
    required this.glyphs,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: glyphs.length,
      itemBuilder: (context, index) {
        final glyph = glyphs.elementAt(index);
        return GlyphTileViewCreator(
          glyph: glyph,
          glyphContentBuilder: (BuildContext context, Glyph glyph) {
            return RectangularGlyphTileContentView(glyph: glyph);
          },
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
    );
  }
}

class _AdView extends StatelessWidget {
  final AdType adType;

  const _AdView({
    required this.adType,
  });

  @override
  Widget build(BuildContext context) {
    switch (adType) {
      case AdType.exabox:
        return const _AdContainerView(
          child: ExaboxAdView(),
        );
      case AdType.hexee:
        return const _AdContainerView(
          child: HexeeProAdView(),
        );
      case AdType.wmap:
        return const _AdContainerView(
          child: WMapAdView(),
        );
      case AdType.iroiro:
        return const _AdContainerView(
          child: IroIronAdView(),
        );
      case AdType.none:
        return const SizedBox();
    }
  }
}

class _AdContainerView extends StatelessWidget {
  final Widget child;

  const _AdContainerView({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 21,
        right: 21,
        bottom: 21,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Material(
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(21),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
