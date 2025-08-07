import 'package:app/preferences/data-controller.dart';
import 'package:app/preferences/data-state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeModeToggleViewCreator extends StatelessWidget {
  const ThemeModeToggleViewCreator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesDataController, PreferencesDataState>(
      builder: (context, state) {
        return ThemeModeToggleView(
          controller: context.read<PreferencesDataController>(),
          state: state,
        );
      },
    );
  }
}

class ThemeModeToggleView extends StatelessWidget {
  final PreferencesDataController controller;
  final PreferencesDataState state;

  const ThemeModeToggleView({
    super.key,
    required this.controller,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: IconButton(
        onPressed: controller.toggleThemeMode,
        icon:
            state.themeMode ==
                    ThemeMode
                        .light //
                ? const Icon(CupertinoIcons.moon)
                : const Icon(CupertinoIcons.sun_max),
      ),
    );
  }
}
