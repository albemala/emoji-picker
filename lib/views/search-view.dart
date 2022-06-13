import 'package:app/providers.dart';
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
      decoration: const InputDecoration(
        hintText: 'Search for emojis and symbols',
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
      onChanged: (value) {
        ref.read(visibleGlyphsProvider.notifier).onSearchChanged(value);
      },
    );
  }
}
