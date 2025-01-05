import 'package:app/search/data-controller.dart';
import 'package:app/search/data-state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewCreator extends StatelessWidget {
  const SearchViewCreator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchGlyphsDataController, SearchGlyphsDataState>(
      builder: (context, state) {
        return SearchView(
          controller: context.read<SearchGlyphsDataController>(),
        );
      },
    );
  }
}

class SearchView extends StatelessWidget {
  final SearchGlyphsDataController controller;

  const SearchView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      focusNode: controller.searchFocusNode,
      controller: controller.searchQueryController,
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
      onChanged: controller.setSearchQuery,
    );
  }
}
