import 'package:app/views/glyph-details.dart';
import 'package:app/views/glyph-list.dart';
import 'package:app/views/top-bar.dart';
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
                const TopBarView(),
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
