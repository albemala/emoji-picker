import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyph-tile/view.dart';
import 'package:app/glyphs/view-controller.dart';
import 'package:app/glyphs/view-state.dart';
import 'package:app/responsive.dart';
import 'package:app/selected-tab/data-controller.dart';
import 'package:app/theme/text.dart';
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

  const GlyphsView({super.key, required this.controller, required this.state});

  @override
  Widget build(BuildContext context) {
    // On desktop screens, show all three content sections side by side
    if (isDesktopScreen(context)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Emoji section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21, vertical: 16),
                  child: Text(
                    'Emoji',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(child: _EmojiView(state: state)),
              ],
            ),
          ),
          // Symbols section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21, vertical: 16),
                  child: Text(
                    'Symbols',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(child: _SymbolsView(state: state)),
              ],
            ),
          ),
          // Kaomoji section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21, vertical: 16),
                  child: Text(
                    'Kaomoji',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(child: _KaomojiView(state: state)),
              ],
            ),
          ),
          // Favorites section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21, vertical: 16),
                  child: Text(
                    'Favorites',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(child: _FavoritesView(state: state)),
              ],
            ),
          ),
        ],
      );
    }

    // On mobile and tablet screens, use the tabbed interface
    final tabController =
        context.read<SelectedTabDataController>().tabController;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return TabBar(
              controller: tabController,
              isScrollable: constraints.maxWidth > 480,
              labelPadding: const EdgeInsets.symmetric(horizontal: 21),
              tabs: const [
                Tab(text: 'Emoji'),
                Tab(text: 'Symbols'),
                Tab(text: 'Kaomoji'),
                Tab(text: 'Favorites'),
              ],
            );
          },
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _EmojiView(state: state),
              _SymbolsView(state: state),
              _KaomojiView(state: state),
              _FavoritesView(state: state),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmojiView extends StatelessWidget {
  final GlyphsViewState state;

  const _EmojiView({required this.state});

  @override
  Widget build(BuildContext context) {
    final allGroups = [
      ...state.recentEmoji,
      ...state.emoji,
    ];
    return _GlyphGroupView(
      groups: allGroups.toIList(),
      groupBuilder: (context, glyphs) {
        return _GlyphGroupGridView(glyphs: glyphs);
      },
    );
  }
}

class _SymbolsView extends StatelessWidget {
  final GlyphsViewState state;

  const _SymbolsView({required this.state});

  @override
  Widget build(BuildContext context) {
    final allGroups = [
      ...state.recentSymbols,
      ...state.symbols,
    ];
    return _GlyphGroupView(
      groups: allGroups.toIList(),
      groupBuilder: (context, glyphs) {
        return _GlyphGroupGridView(glyphs: glyphs);
      },
    );
  }
}

class _KaomojiView extends StatelessWidget {
  final GlyphsViewState state;

  const _KaomojiView({required this.state});

  @override
  Widget build(BuildContext context) {
    final allGroups = [
      ...state.recentKaomoji,
      ...state.kaomoji,
    ];
    return _GlyphGroupView(
      groups: allGroups.toIList(),
      groupBuilder: (context, glyphs) {
        return _GlyphGroupListView(glyphs: glyphs);
      },
    );
  }
}

class _FavoritesView extends StatelessWidget {
  final GlyphsViewState state;

  const _FavoritesView({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.favorites.isEmpty) {
      return const Center(
        child: Text('Your favorite glyphs will appear here.'),
      );
    }
    return _GlyphGroupView(
      groups: state.favorites,
      groupBuilder: (context, glyphs) {
        return glyphs.first.type == GlyphType.kaomoji
            ? _GlyphGroupListView(glyphs: glyphs)
            : _GlyphGroupGridView(glyphs: glyphs);
      },
    );
  }
}

class _GlyphGroupView extends StatelessWidget {
  final IList<GlyphGroupViewState> groups;
  final Widget Function(BuildContext, List<Glyph>) groupBuilder;

  const _GlyphGroupView({required this.groups, required this.groupBuilder});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers:
          groups.map((group) {
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
              ],
            );
          }).toList(),
    );
  }
}

class _GlyphGroupTitleView extends StatelessWidget {
  final String title;

  const _GlyphGroupTitleView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 8),
        child: Text(
          title.toUpperCase(),
          style: getBodyTextStyle(context),
        ),
      ),
    );
  }
}

class _GlyphGroupGridView extends StatelessWidget {
  final List<Glyph> glyphs;

  const _GlyphGroupGridView({required this.glyphs});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 56,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final glyph = glyphs.elementAt(index);
        return GlyphTileViewCreator(
          glyph: glyph,
          glyphContentBuilder: (BuildContext context, Glyph glyph) {
            return SquaredGlyphTileContentView(glyph: glyph);
          },
        );
      }, childCount: glyphs.length),
    );
  }
}

class _GlyphGroupListView extends StatelessWidget {
  final List<Glyph> glyphs;

  const _GlyphGroupListView({required this.glyphs});

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
        return const SizedBox(height: 4);
      },
    );
  }
}
