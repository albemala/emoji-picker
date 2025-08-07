import 'package:app/search/view-controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewCreator extends StatelessWidget {
  const SearchViewCreator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchGlyphsViewController>(
      create: SearchGlyphsViewController.fromContext,
      child: BlocBuilder<SearchGlyphsViewController, void>(
        builder: (context, state) {
          return SearchView(
            controller: context.read<SearchGlyphsViewController>(),
          );
        },
      ),
    );
  }
}

class SearchView extends StatelessWidget {
  final SearchGlyphsViewController controller;

  const SearchView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      focusNode: controller.focusNode,
      controller: controller.queryController,
      decoration: InputDecoration(
        hintText: 'Search for emoji and symbols',
        contentPadding: const EdgeInsets.symmetric(horizontal: 21),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
            iconSize: 16,
            icon: const Icon(CupertinoIcons.clear),
            onPressed: controller.clearSearch,
          ),
        ),
      ),
    );
  }
}
