import 'package:app/search/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_management/flutter_state_management.dart';

class SearchViewCreator extends StatelessWidget {
  const SearchViewCreator({super.key});

  @override
  Widget build(BuildContext context) {
    return ConductorConsumer<SearchGlyphsConductor>(
      builder: (context, filteredGlyphsConductor) {
        return SearchView(
          filteredGlyphsConductor: filteredGlyphsConductor,
        );
      },
    );
  }
}

class SearchView extends StatelessWidget {
  final SearchGlyphsConductor filteredGlyphsConductor;

  const SearchView({
    super.key,
    required this.filteredGlyphsConductor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      focusNode: filteredGlyphsConductor.searchFocusNode,
      controller: filteredGlyphsConductor.searchQueryController,
      decoration: InputDecoration(
        hintText: 'Search for emoji and symbols',
        contentPadding: const EdgeInsets.symmetric(horizontal: 21),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
            iconSize: 16,
            icon: const Icon(CupertinoIcons.clear),
            onPressed: filteredGlyphsConductor.clearSearch,
          ),
        ),
      ),
      onChanged: filteredGlyphsConductor.setSearchQuery,
    );
  }
}
