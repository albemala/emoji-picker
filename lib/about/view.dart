import 'package:app/about/view-controller.dart';
import 'package:app/about/view-state.dart';
import 'package:app/app/defines.dart';
import 'package:app/share.dart';
import 'package:app/theme/text.dart';
import 'package:app/urls/defines.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutViewCreator extends StatelessWidget {
  const AboutViewCreator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AboutViewController>(
      create: AboutViewController.fromContext,
      child: BlocBuilder<AboutViewController, AboutViewState>(
        builder: (context, state) {
          return AboutView(
            controller: context.read<AboutViewController>(),
            state: state,
          );
        },
      ),
    );
  }
}

class AboutView extends StatelessWidget {
  final AboutViewController controller;
  final AboutViewState state;

  const AboutView({super.key, required this.controller, required this.state});

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
                _AppInfoView(controller: controller, state: state),
                _AppActionsView(controller: controller, state: state),
                OutlinedButton(
                  onPressed: controller.openOtherApps,
                  child: const Text('Other Apps'),
                ),
                _SupportView(controller: controller, state: state),
                _NewsView(controller: controller, state: state),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppInfoView extends StatelessWidget {
  final AboutViewController controller;
  final AboutViewState state;

  const _AppInfoView({required this.controller, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 16,
      children: [
        Image.asset(
          'assets/app-icon/app-icon.png',
          width: 56,
          height: 56,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appName, style: getHeadlineTextStyle(context)),
            Row(
              children: [
                Text(state.appVersion, style: getLabelTextStyle(context)),
                // LinkButton(
                //   onPressed: bloc.showReleaseNotes,
                //   text: "What's new?",
                // ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _AppActionsView extends StatelessWidget {
  final AboutViewController controller;
  final AboutViewState state;

  const _AppActionsView({required this.controller, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: FilledButton(
            onPressed: controller.openRateApp,
            child: const Text(
              'Rate',
            ),
          ),
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              return FilledButton(
                onPressed: () {
                  controller.openShareApp(
                    '''
        Find and copy unicode characters, emoji, kaomoji and symbols with Ejimo: $repositoryUrl''',
                    getSharePosition(context),
                  );
                },
                child: const Text(
                  'Share',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SupportView extends StatelessWidget {
  final AboutViewController controller;
  final AboutViewState state;

  const _SupportView({required this.controller, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'Help & Support'.toUpperCase(),
          style: getSubtitleTextStyle(context),
        ),
        OutlinedButton(
          onPressed: controller.openEmail,
          child: const Text('Email'),
        ),
        OutlinedButton(
          onPressed: controller.openWebsite,
          child: const Text('Website'),
        ),
      ],
    );
  }
}

class _NewsView extends StatelessWidget {
  final AboutViewController controller;
  final AboutViewState state;

  const _NewsView({required this.controller, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'News, Tips & Tricks'.toUpperCase(),
          style: getSubtitleTextStyle(context),
        ),
        OutlinedButton(
          onPressed: controller.openTwitter,
          child: const Text('Twitter'),
        ),
      ],
    );
  }
}
