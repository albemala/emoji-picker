import 'package:app/search/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewBuilder extends StatelessWidget {
  const SearchViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchGlyphsBloc, SearchGlyphsState>(
      builder: (context, state) {
        return SearchView(
          bloc: context.read<SearchGlyphsBloc>(),
        );
      },
    );
  }
}

class SearchView extends StatelessWidget {
  final SearchGlyphsBloc bloc;

  const SearchView({
    super.key,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      focusNode: bloc.searchFocusNode,
      controller: bloc.searchQueryController,
      decoration: InputDecoration(
        hintText: 'Search for emoji and symbols',
        contentPadding: const EdgeInsets.symmetric(horizontal: 21),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
            iconSize: 16,
            icon: const Icon(CupertinoIcons.clear),
            onPressed: bloc.clearSearch,
          ),
        ),
      ),
      onChanged: bloc.setSearchQuery,
    );
  }
}
