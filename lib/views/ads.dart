import 'package:app/defines/urls.dart';
import 'package:app/functions/url.dart';
import 'package:flutter/material.dart';

class ExaboxAdView extends StatelessWidget {
  const ExaboxAdView({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseAdView(
      iconAssetPath: 'assets/images/exabox-icon.png',
      overline: 'Are you a software developer?',
      title: 'Exabox: Essential tools for developers',
      description: '''
30+ tools: convert/format JSON/YAML, encode/decode Base64, generate fake data, parse JWTs, transform text using multiple rules, and much more. All in one single app. Work offline. Privacy-friendly.''',
      onLearnMore: () {
        openUrl(exaboxWebsiteUrl);
      },
    );
  }
}

class HexeeProAdView extends StatelessWidget {
  const HexeeProAdView({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseAdView(
      iconAssetPath: 'assets/images/hexee-pro-icon.png',
      overline: 'Are you a designer or artist?',
      title: 'Hexee Pro: Advanced palette & color tools',
      description: '''
Hexee Pro is the ultimate palette editor and color tool for designers and artists. If you're tired of switching between multiple apps to work with colors, Hexee Pro is the perfect solution for you.''',
      onLearnMore: () {
        openUrl(hexeeWebsiteUrl);
      },
    );
  }
}

class WMapAdView extends StatelessWidget {
  const WMapAdView({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseAdView(
      iconAssetPath: 'assets/images/wmap-icon.png',
      overline: 'Mobile app',
      title: 'WMap: Map Wallpapers & Backgrounds',
      description: '''
Create beautiful, minimal, custom map wallpapers and backgrounds for your phone or tablet.''',
      onLearnMore: () {
        openUrl(wmapWebsiteUrl);
      },
    );
  }
}

class IroIronAdView extends StatelessWidget {
  const IroIronAdView({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseAdView(
      iconAssetPath: 'assets/images/iro-iro-icon.png',
      overline: 'Game',
      title: 'Iro-Iro: Relaxing Color Puzzle',
      description: '''
Arrange colors to form amazing patterns in this relaxing colour puzzle game!''',
      onLearnMore: () {
        openUrl(iroIroWebsiteUrl);
      },
    );
  }
}

class _BaseAdView extends StatelessWidget {
  final String iconAssetPath;
  final String overline;
  final String title;
  final String description;
  final void Function() onLearnMore;

  const _BaseAdView({
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
