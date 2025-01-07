import 'package:app/app-content/view-controller.dart';
import 'package:app/app-content/view-state.dart';
import 'package:app/glyph-details/view.dart';
import 'package:app/glyphs/view.dart';
import 'package:app/search/view.dart';
import 'package:app/widgets/about.dart';
import 'package:app/widgets/preferences.dart';
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
    return const Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeaderView(),
            Expanded(
              child: GlyphsViewCreator(),
            ),
            GlyphDetailsViewCreator(),
          ],
        ),
      ),
    );
  }
}

class _HeaderView extends StatelessWidget {
  const _HeaderView();

  @override
  Widget build(BuildContext context) {
    return const Padding(
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
    );
  }
}
