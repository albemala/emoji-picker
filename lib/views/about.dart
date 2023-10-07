import 'package:app/defines/app.dart';
import 'package:app/defines/urls.dart';
import 'package:app/functions/app.dart';
import 'package:app/functions/math.dart';
import 'package:app/functions/share.dart';
import 'package:app/functions/url.dart';
import 'package:app/views/ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_management/flutter_state_management.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:send_support_email/send_support_email.dart';

class AboutViewConductor extends Conductor {
  factory AboutViewConductor.fromContext(BuildContext context) {
    return AboutViewConductor();
  }

  final appVersion = ValueNotifier<String>('...');

  AboutViewConductor() {
    _init();
  }

  Future<void> _init() async {
    appVersion.value = await getAppVersion();
  }

  @override
  void dispose() {
    appVersion.dispose();
  }

  Future<void> openRateApp() async {
    await InAppReview.instance.openStoreListing(
      appStoreId: appleAppId,
      microsoftStoreId: microsoftStoreId,
    );
  }

  Future<void> openShareApp(
    String message,
    Rect sharePosition,
  ) async {
    await shareText(
      position: sharePosition,
      text: message,
    );
  }

  Future<void> openOtherApps() async {
    await openUrl(otherProjectsUrl);
  }

  Future<void> openEmail() async {
    final email = await generateSupportEmail(supportEmailUrl);
    await openUrl(email);
  }

  Future<void> openWebsite() async {
    await openUrl(repositoryUrl);
  }

  Future<void> openTwitter() async {
    await openUrl(twitterUrl);
  }
}

class AboutViewCreator extends StatelessWidget {
  const AboutViewCreator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ConductorCreator(
      create: AboutViewConductor.fromContext,
      child: AboutView(),
    );
  }
}

class AboutView extends StatelessWidget {
  const AboutView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(24),
              child: _AboutContentView(),
            ),
            Material(
              type: MaterialType.card,
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

class _AboutContentView extends StatelessWidget {
  const _AboutContentView();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AppInfoView(),
        SizedBox(height: 12),
        _AppActionsView(),
        SizedBox(height: 16),
        _SupportView(),
        SizedBox(height: 16),
        _NewsView(),
      ],
    );
  }
}

class _AppInfoView extends StatelessWidget {
  const _AppInfoView();

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
                ValueListenableBuilder(
                  valueListenable:
                      context.getConductor<AboutViewConductor>().appVersion,
                  builder: (context, appVersion, _) {
                    return Text(
                      appVersion,
                      style: Theme.of(context).textTheme.bodySmall,
                    );
                  },
                ),
                // const SizedBox(width: 8),
                // LinkButton(
                //   onPressed: context.read<AboutViewBloc>().showReleaseNotes,
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
  const _AppActionsView();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        OutlinedButton(
          onPressed: () {
            context.getConductor<AboutViewConductor>().openRateApp();
          },
          child: const Text('Rate'),
        ),
        OutlinedButton(
          onPressed: () {
            context.getConductor<AboutViewConductor>().openShareApp(
              '''
Find and copy unicode characters, emoji, kaomoji and symbols with Ejimo: $repositoryUrl''',
              getSharePosition(context),
            );
          },
          child: const Text('Share'),
        ),
        FilledButton(
          onPressed: () {
            context.getConductor<AboutViewConductor>().openOtherApps();
          },
          child: const Text('Other Apps'),
        ),
      ],
    );
  }
}

class _SupportView extends StatelessWidget {
  const _SupportView();

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
              onPressed: () {
                context.getConductor<AboutViewConductor>().openEmail();
              },
              child: const Text('Email'),
            ),
            OutlinedButton(
              onPressed: () {
                context.getConductor<AboutViewConductor>().openWebsite();
              },
              child: const Text('Website'),
            ),
          ],
        ),
      ],
    );
  }
}

class _NewsView extends StatelessWidget {
  const _NewsView();

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
              onPressed: () {
                context.getConductor<AboutViewConductor>().openTwitter();
              },
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
