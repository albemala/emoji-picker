import 'package:app/providers.dart';
import 'package:app/views/ad-view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
