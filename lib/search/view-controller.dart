import 'dart:async';

import 'package:app/search/data-controller.dart';
import 'package:app/search/data-state.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchGlyphsViewController extends Cubit<void> {
  final SearchGlyphsDataController _searchGlyphsDataController;

  final focusNode = FocusNode();
  final queryController = TextEditingController();

  factory SearchGlyphsViewController.fromContext(BuildContext context) {
    return SearchGlyphsViewController(
      context.read<SearchGlyphsDataController>(),
    );
  }

  SearchGlyphsViewController(
    this._searchGlyphsDataController,
  ) : super(defaultSearchGlyphsDataState) {
    focusNode.addListener(onFocusChanged);
    queryController.addListener(onQueryChanged);
  }

  @override
  Future<void> close() async {
    focusNode
      ..removeListener(onFocusChanged)
      ..dispose();
    queryController
      ..removeListener(onQueryChanged)
      ..dispose();
    await super.close();
  }

  void onFocusChanged() {}

  void clearSearch() {
    queryController.clear();
  }

  void onQueryChanged() {
    EasyDebounce.debounce(
      'search-debounce',
      const Duration(milliseconds: 300),
      updateDataController,
    );
  }

  void updateDataController() {
    final query = queryController.text;
    _searchGlyphsDataController.setSearchQuery(query);
  }
}
