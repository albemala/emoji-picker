import 'package:app/defines/urls.dart';
import 'package:app/functions/app.dart';
import 'package:app/functions/math.dart';
import 'package:app/functions/url.dart';
import 'package:app/views/ads.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_management/flutter_state_management.dart';
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

/* TODO
  Future<void> openRateApp() async {
    await InAppReview.instance.openStoreListing(
      appStoreId: appleAppId,
    );
  }
*/

/* TODO
  Future<void> openShareApp(
      String message,
      Rect sharePosition,
      ) async {
    await shareText(
      position: sharePosition,
      text: message,
    );
  }
*/

/* TODO
  Future<void> openOtherApps() async {
    await openUrl(otherProjectsUrl);
  }
*/

  Future<void> openSendFeedback() async {
    final email = await generateSupportEmail(supportEmailUrl);
    await openUrl(email);
  }

  Future<void> openTwitter() async {
    await openUrl(twitterUrl);
  }

  Future<void> openRepository() async {
    await openUrl(repositoryUrl);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: _AboutContentView(),
            ),
            Material(
              surfaceTintColor: Theme.of(context).colorScheme.primary,
              elevation: Theme.of(context).brightness == Brightness.light //
                  ? 1
                  : 12,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
    return const Wrap(
      spacing: 24,
      runSpacing: 24,
      children: [
        _AppInfoView(),
        _SupportView(),
        _SocialView(),
        _RepositoryView(),
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
              getAppName(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Row(
              children: [
                ValueListenableBuilder<String>(
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

class _SupportView extends StatelessWidget {
  const _SupportView();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Help & Support'),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {
            context.getConductor<AboutViewConductor>().openSendFeedback();
          },
          child: const Text(
            'Send Feedback',
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}

class _SocialView extends StatelessWidget {
  const _SocialView();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Follow me!'),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {
            context.getConductor<AboutViewConductor>().openTwitter();
          },
          child: const Text('Twitter'),
        ),
      ],
    );
  }
}

class _RepositoryView extends StatelessWidget {
  const _RepositoryView();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Source code available on ',
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: 'GitHub',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.getConductor<AboutViewConductor>().openRepository();
              },
          ),
        ],
      ),
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
