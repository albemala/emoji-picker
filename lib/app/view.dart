import 'package:app/app-content/view.dart';
import 'package:app/app/defines.dart';
import 'package:app/app/view-controller.dart';
import 'package:app/app/view-state.dart';
import 'package:app/shortcuts/intents-actions.dart';
import 'package:app/theme/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppViewCreator extends StatelessWidget {
  const AppViewCreator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppViewController>(
      create: AppViewController.fromContext,
      child: BlocBuilder<AppViewController, AppViewState>(
        builder: (context, state) {
          return AppView(
            controller: context.read<AppViewController>(),
            state: state,
          );
        },
      ),
    );
  }
}

class AppView extends StatelessWidget {
  final AppViewController controller;
  final AppViewState state;

  const AppView({required this.controller, required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: state.themeMode == ThemeMode.dark
            ? Brightness.dark
            : Brightness.light,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: getLightTheme(),
      darkTheme: getDarkTheme(),
      themeMode: state.themeMode,
      home: state.isLoading
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : Builder(
              builder: (context) {
                return Shortcuts(
                  shortcuts: shortcuts,
                  child: Actions(
                    actions: {
                      FocusSearchIntent: FocusSearchAction(context),
                      CopyGlyphIntent: CopyGlyphAction(context),
                    },
                    child: const AppContentViewCreator(),
                  ),
                );
              },
            ),
    );
  }
}
