import 'package:app/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchView extends HookConsumerWidget {
  final FocusNode focusNode;

  const SearchView({
    super.key,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();

    // When the search field gets focused, select the existing text
    useListenable(focusNode);
    if (focusNode.hasFocus) {
      textEditingController.value = textEditingController.value.copyWith(
        selection: TextSelection(
          baseOffset: 0,
          extentOffset: textEditingController.text.length,
        ),
        composing: TextRange.empty,
      );
    }

    return TextField(
      autofocus: true,
      focusNode: focusNode,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: 'Search for emojis and symbols',
        contentPadding: const EdgeInsets.symmetric(horizontal: 21),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
            iconSize: 16,
            icon: const Icon(CupertinoIcons.clear),
            onPressed: () {
              textEditingController.clear();
              ref.read(visibleGlyphsProvider.notifier).clearSearch();
            },
          ),
        ),
      ),
      onChanged: (value) {
        ref.read(visibleGlyphsProvider.notifier).onSearchChanged(value);
      },
    );
  }
}
