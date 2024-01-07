import 'package:app/preferences/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleThemeModeViewBuilder extends StatelessWidget {
  const ToggleThemeModeViewBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesBloc, PreferencesState>(
      builder: (context, state) {
        return ToggleThemeModeView(
          bloc: context.read<PreferencesBloc>(),
          viewModel: state,
        );
      },
    );
  }
}

class ToggleThemeModeView extends StatelessWidget {
  final PreferencesBloc bloc;
  final PreferencesState viewModel;

  const ToggleThemeModeView({
    super.key,
    required this.bloc,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: IconButton(
        onPressed: bloc.toggleThemeMode,
        icon: viewModel.themeMode == ThemeMode.light //
            ? const Icon(CupertinoIcons.moon)
            : const Icon(CupertinoIcons.sun_max),
      ),
    );
  }
}
