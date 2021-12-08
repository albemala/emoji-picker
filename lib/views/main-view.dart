import 'dart:io';

import 'package:app/intents-actions.dart';
import 'package:app/providers.dart';
import 'package:app/views/about-view.dart';
import 'package:app/views/glyph-details-view.dart';
import 'package:app/views/glyph-list-view.dart';
import 'package:app/views/search-view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainView extends HookConsumerWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final glyphWithDetails = ref.watch(glyphDetailsProvider);
    final searchViewFocusNode = useFocusNode();
    return Shortcuts(
      shortcuts: {
        // focus search
        if (Platform.isMacOS) //
          LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyF): const FocusSearchIntent(),
        if (Platform.isWindows || Platform.isLinux) //
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyF): const FocusSearchIntent(),
        // copy glyph
        if (Platform.isMacOS) //
          LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyC): const CopyGlyphIntent(),
        if (Platform.isWindows || Platform.isLinux) //
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyC): const CopyGlyphIntent(),
      },
      child: Actions(
        actions: {
          FocusSearchIntent: FocusSearchAction(searchViewFocusNode),
          CopyGlyphIntent: CopyGlyphAction(context, glyphWithDetails?.char),
        },
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
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
              ),
              const Expanded(
                child: GlyphListView(),
              ),
              GlyphDetailsView(
                glyph: glyphWithDetails,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
