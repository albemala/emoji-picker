import 'package:app/app-content/view-controller.dart';
import 'package:app/app-content/view-state.dart';
import 'package:app/glyph-details/view.dart';
import 'package:app/glyph-list/view.dart';
import 'package:app/widgets/about.dart';
import 'package:app/widgets/preferences.dart';
import 'package:app/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppContentViewCreator extends StatelessWidget {
  const AppContentViewCreator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppContentViewController>(
      create: AppContentViewController.fromContext,
      child: BlocBuilder<AppContentViewController, AppContentViewState>(
        builder: (context, state) {
          return AppContentView(
            controller: context.read<AppContentViewController>(),
            state: state,
          );
        },
      ),
    );
  }
}

class AppContentView extends StatelessWidget {
  final AppContentViewController controller;
  final AppContentViewState state;

  const AppContentView({
    super.key,
    required this.controller,
    required this.state,
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
                      ThemeModeToggleViewCreator(),
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
                GlyphDetailsViewCreator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
