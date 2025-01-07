import 'dart:async';

import 'package:app/search/data-controller.dart';
import 'package:app/search/data-state.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchGlyphsViewController extends Cubit<void> {
  final SearchGlyphsDataController _searchGlyphsDataController;

  final queryController = TextEditingController();

  FocusNode get focusNode => _searchGlyphsDataController.focusNode;

  factory SearchGlyphsViewController.fromContext(BuildContext context) {
    return SearchGlyphsViewController(
      context.read<SearchGlyphsDataController>(),
    );
  }

  SearchGlyphsViewController(
    this._searchGlyphsDataController,
  ) : super(defaultSearchGlyphsDataState) {
    queryController.addListener(onQueryChanged);
  }

  @override
  Future<void> close() {
    queryController
      ..removeListener(onQueryChanged)
      ..dispose();
    return super.close();
  }

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
