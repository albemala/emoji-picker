import 'package:app/about/widgets.dart';
import 'package:app/glyph-details/view.dart';
import 'package:app/glyph-list/glyph-list-view.dart';
import 'package:app/preferences/widgets.dart';
import 'package:app/search/widgets.dart';
import 'package:flutter/material.dart';

class AppContentView extends StatelessWidget {
  const AppContentView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(21),
                  child: Row(
                    children: [
                      Expanded(
                        child: SearchViewCreator(),
                      ),
                      SizedBox(width: 12),
                      ToggleThemeModeViewCreator(),
                      AboutButtonView(),
                    ],
                  ),
                ),
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
                const Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      EmojiListViewCreator(),
                      SymbolListViewCreator(),
                      KaomojiListViewCreator(),
                    ],
                  ),
                ),
                const GlyphDetailsViewCreator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
