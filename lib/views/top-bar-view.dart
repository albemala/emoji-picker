import 'package:app/providers.dart';
import 'package:app/views/about-view.dart';
import 'package:app/views/search-view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TopBarView extends HookConsumerWidget {
  final FocusNode searchViewFocusNode;

  const TopBarView({
    super.key,
    required this.searchViewFocusNode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 24),
      child: Row(
        children: [
          Expanded(
            child: SearchView(
              focusNode: searchViewFocusNode,
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
            icon: theme == ThemeMode.light //
                ? const Icon(CupertinoIcons.moon)
                : const Icon(CupertinoIcons.sun_max),
          ),
          IconButton(
            onPressed: () {
              AboutView.show(context);
            },
            icon: const Icon(CupertinoIcons.info),
          ),
        ],
      ),
    );
  }
}
