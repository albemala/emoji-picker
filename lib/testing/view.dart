import 'package:app/testing/view-controller.dart';
import 'package:app/testing/view-state.dart';
import 'package:app/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestingViewCreator extends StatelessWidget {
  const TestingViewCreator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TestingViewController>(
      create: TestingViewController.fromContext,
      child: BlocBuilder<TestingViewController, TestingViewState>(
        builder: (context, state) {
          return TestingView(
            controller: context.read<TestingViewController>(),
            state: state,
          );
        },
      ),
    );
  }
}

class TestingView extends StatelessWidget {
  final TestingViewController controller;
  final TestingViewState state;

  const TestingView({super.key, required this.controller, required this.state});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24,
              children: [
                _HeaderView(),
                _ActionsView(controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'Debug Tools',
          style: getHeadlineTextStyle(context),
        ),
        Text(
          'Clear application data for testing purposes.',
          style: getBodyTextStyle(context),
        ),
      ],
    );
  }
}

class _ActionsView extends StatelessWidget {
  final TestingViewController controller;

  const _ActionsView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        FilledButton(
          onPressed: controller.clearFavorites,
          child: const Text('Clear Favorites'),
        ),
        FilledButton(
          onPressed: controller.clearRecents,
          child: const Text('Clear Recents'),
        ),
      ],
    );
  }
}
