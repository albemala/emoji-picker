import 'package:app/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdView extends StatelessWidget {
  final String iconAssetPath;
  final String overline;
  final String title;
  final String description;
  final void Function() onLearnMore;

  const AdView({
    super.key,
    required this.iconAssetPath,
    required this.overline,
    required this.title,
    required this.description,
    required this.onLearnMore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          iconAssetPath,
          width: 48,
          height: 48,
          filterQuality: FilterQuality.medium,
        ),
        const SizedBox(height: 16),
        Text(
          overline.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: onLearnMore,
            child: const Text('Learn more'),
          ),
        ),
      ],
    );
  }
}

class ExaboxAdView extends HookConsumerWidget {
  const ExaboxAdView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdView(
      iconAssetPath: 'assets/images/exabox-icon.png',
      overline: 'Are you a software developer?',
      title: 'Exabox: Essential tools for developers',
      description: '''
30+ tools: convert/format JSON/YAML, encode/decode Base64, generate fake data, parse JWTs, transform text using multiple rules, and much more. All in one single app. Work offline. Privacy-friendly.''',
      onLearnMore: ref.read(urlsProvider).openExaboxWebsite,
    );
  }
}
