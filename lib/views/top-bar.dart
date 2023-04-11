import 'package:app/providers.dart';
import 'package:app/views/about.dart';
import 'package:app/views/search.dart';
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
          SizedBox(
            width: 48,
            height: 48,
            child: IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              icon: theme == ThemeMode.light //
                  ? const Icon(CupertinoIcons.moon)
                  : const Icon(CupertinoIcons.sun_max),
            ),
          ),
          SizedBox(
            width: 48,
            height: 48,
            child: IconButton(
              onPressed: () {
                AboutView.show(context);
              },
              icon: const Icon(CupertinoIcons.info),
            ),
          ),
        ],
      ),
    );
  }
}
