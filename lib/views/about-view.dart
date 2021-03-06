import 'package:app/providers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AboutView extends HookConsumerWidget {
  static Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return const AlertDialog(
          clipBehavior: Clip.hardEdge,
          contentPadding: EdgeInsets.zero,
          content: AboutView(),
        );
      },
    );
  }

  const AboutView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: _AboutContentView(),
            ),
            Material(
              surfaceTintColor: Theme.of(context).colorScheme.primary,
              elevation: Theme.of(context).brightness == Brightness.light ? 1 : 12,
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

class _AboutContentView extends HookConsumerWidget {
  const _AboutContentView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: const [
        _AppInfoView(),
        _SupportView(),
        _SocialView(),
        _RepositoryView(),
      ],
    );
  }
}

class _AppInfoView extends HookConsumerWidget {
  const _AppInfoView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appInfo = ref.watch(appInfoProvider);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/app-icon.png',
          width: 48,
          height: 48,
        ),
        const SizedBox(width: 16),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appInfo.appName(),
              style: Theme.of(context).textTheme.headline5,
            ),
            Row(
              children: [
                FutureBuilder<String>(
                  future: appInfo.appVersion(),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: Theme.of(context).textTheme.caption,
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

class _SupportView extends HookConsumerWidget {
  const _SupportView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Help & Support'),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {
            ref.read(urlsProvider).sendFeedback();
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

class _SocialView extends HookConsumerWidget {
  const _SocialView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Follow me!'),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {
            ref.read(urlsProvider).openTwitter();
          },
          child: const Text('Twitter'),
        ),
      ],
    );
  }
}

class _RepositoryView extends HookConsumerWidget {
  const _RepositoryView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RichText(
      text: TextSpan(
        text: 'Source code available on ',
        style: Theme.of(context).textTheme.bodyText2,
        children: [
          TextSpan(
            text: 'GitHub',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                ref.read(urlsProvider).openRepository();
              },
          ),
        ],
      ),
    );
  }
}

class _AdView extends HookConsumerWidget {
  const _AdView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/exabox-icon.png',
          width: 48,
          height: 48,
        ),
        const SizedBox(height: 16),
        Text(
          'Are you a software developer?'.toUpperCase(),
          style: Theme.of(context).textTheme.caption,
        ),
        Text(
          'Exabox: Essential tools for developers',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 8),
        Text(
          '''
30+ tools: convert/format JSON/YAML, encode/decode Base64, generate fake data, parse JWTs, transform text using multiple rules, and much more. 
All in one single app. Work offline. Privacy-friendly.''',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              ref.read(urlsProvider).openExaboxWebsite();
            },
            child: const Text('Learn more'),
          ),
        ),
      ],
    );
  }
}
