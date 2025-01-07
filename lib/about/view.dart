import 'package:app/about/view-controller.dart';
import 'package:app/about/view-state.dart';
import 'package:app/app/defines.dart';
import 'package:app/math.dart';
import 'package:app/share.dart';
import 'package:app/urls/defines.dart';
import 'package:app/widgets/ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutViewCreator extends StatelessWidget {
  const AboutViewCreator({
    super.key,
  });

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

  const AboutView({
    super.key,
    required this.controller,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AppInfoView(
                    appVersion: state.appVersion,
                  ),
                  const SizedBox(height: 12),
                  _AppActionsView(
                    onRate: controller.openRateApp,
                    onShare: controller.openShareApp,
                    onOtherApps: controller.openOtherApps,
                  ),
                  const SizedBox(height: 16),
                  _SupportView(
                    onOpenEmail: controller.openEmail,
                    onOpenWebsite: controller.openWebsite,
                  ),
                  const SizedBox(height: 16),
                  _NewsView(
                    onOpenTwitter: controller.openTwitter,
                  ),
                ],
              ),
            ),
            const Material(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: _AdView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppInfoView extends StatelessWidget {
  final String appVersion;

  const _AppInfoView({
    required this.appVersion,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: const Offset(0, 2),
          child: Image.asset(
            'assets/images/app-icon.png',
            width: 48,
            height: 48,
            filterQuality: FilterQuality.medium,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Row(
              children: [
                Text(
                  appVersion,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                // const SizedBox(width: 8),
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
  final void Function() onRate;
  final void Function(String, Rect) onShare;
  final void Function() onOtherApps;

  const _AppActionsView({
    required this.onRate,
    required this.onShare,
    required this.onOtherApps,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        OutlinedButton(
          onPressed: onRate,
          child: const Text('Rate'),
        ),
        Builder(
          builder: (context) {
            return OutlinedButton(
              onPressed: () {
                onShare(
                  '''
Find and copy unicode characters, emoji, kaomoji and symbols with Ejimo: $repositoryUrl''',
                  getSharePosition(context),
                );
              },
              child: const Text('Share'),
            );
          },
        ),
        FilledButton(
          onPressed: onOtherApps,
          child: const Text('Other Apps'),
        ),
      ],
    );
  }
}

class _SupportView extends StatelessWidget {
  final void Function() onOpenEmail;
  final void Function() onOpenWebsite;

  const _SupportView({
    required this.onOpenEmail,
    required this.onOpenWebsite,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Help & Support'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton(
              onPressed: onOpenEmail,
              child: const Text('Email'),
            ),
            OutlinedButton(
              onPressed: onOpenWebsite,
              child: const Text('Website'),
            ),
          ],
        ),
      ],
    );
  }
}

class _NewsView extends StatelessWidget {
  final void Function() onOpenTwitter;

  const _NewsView({
    required this.onOpenTwitter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('News, Tips & Tricks'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton(
              onPressed: onOpenTwitter,
              child: const Text('Twitter'),
            ),
          ],
        ),
      ],
    );
  }
}

class _AdView extends StatelessWidget {
  const _AdView();

  @override
  Widget build(BuildContext context) {
    // randomize which ad to show
    final random = randomInt(1, 4);
    if (random == 1) return const ExaboxAdView();
    if (random == 2) return const HexeeProAdView();
    if (random == 3) return const WMapAdView();
    if (random == 4) return const IroIronAdView();
    return const SizedBox();
  }
}
