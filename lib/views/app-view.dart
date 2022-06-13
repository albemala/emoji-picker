import 'package:app/assets/app-theme.dart';
import 'package:app/providers.dart';
import 'package:app/views/main-view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppView extends HookConsumerWidget {
  const AppView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ejimo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: theme,
      home: const MainView(),
    );
  }
}
