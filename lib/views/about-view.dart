import 'package:app/providers.dart';
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 480),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [_AboutContentView(), _AdView()],
      ),
    );
  }
}

class _AboutContentView extends HookConsumerWidget {
  const _AboutContentView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appInfo = ref.watch(appInfoProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 32,
            runSpacing: 24,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/app-icon.png',
                    width: 48,
                    height: 48,
                  ),
                  const SizedBox(width: 16),
                  Column(
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
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Help & Support'),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      ref.read(urlsProvider).sendFeedback();
                    },
                    child: const Text('Send Feedback'),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Follow me!'),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      ref.read(urlsProvider).openTwitter();
                    },
                    child: const Text('Twitter'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AdView extends HookConsumerWidget {
  const _AdView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/exabox-icon.png',
            width: 48,
            height: 48,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Are you a software developer?'.toUpperCase(),
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  'Exabox: Essential tools for developers',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 4),
                Text(
                  '''
30+ tools: convert/format JSON/YAML, encode/decode Base64, generate fake data, parse JWTs, transform text using multiple rules, and much more. 
All in one single app. Work offline. Privacy-friendly.''',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
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
            ),
          ),
        ],
      ),
    );
  }
}
