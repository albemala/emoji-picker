import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:app/theme/text.dart';
import 'package:app/urls.dart';
import 'package:flutter/material.dart';

class AdData {
  final String iconAssetPath;
  final String overline;
  final String title;
  final String description;
  final String url;

  const AdData({
    required this.iconAssetPath,
    required this.overline,
    required this.title,
    required this.description,
    required this.url,
  });
}

final exaboxAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/exabox.png',
  overline: 'Your coding companion',
  title: 'Exabox: Essential tools for developers',
  description: '''
The ultimate developer toolkit in your pocket. Transform, inspect, and manipulate data with 30+ essential utilities.''',
  url: exaboxUrl,
);

final hexeeProAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/hexee-pro.png',
  overline: 'Your color workspace',
  title: 'Hexee Pro: Advanced palette & color tools',
  description: '''
Advanced color tools for designers and artists in one unified workspace. Create, edit, and organize palettes, fine-tune colors, and check accessibility.''',
  url: hexeeProUrl,
);

final paletteConverterAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/upc.png',
  overline: 'Color palettes, simplified',
  title: 'Universal Palette Converter',
  description: '''
The ultimate solution for managing and converting color palettes across various formats.''',
  url: paletteConverterUrl,
);

final wmapAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/wmap.png',
  overline: 'Your world, your wallpaper',
  title: 'WMap: Map Wallpapers & Backgrounds',
  description: '''
Create beautiful, minimal, custom map wallpapers and backgrounds for your phone or tablet.''',
  url: wmapUrl,
);

final iroIroAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/iro-iro.png',
  overline: 'Color sorting game',
  title: 'Iro-Iro: Relaxing Color Puzzle',
  description: '''
Arrange colors to form amazing patterns in this relaxing colour puzzle game!''',
  url: iroIroUrl,
);

final ejimoAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/ejimo.png',
  overline: 'Characters at your fingertips',
  title: 'Ejimo: Emoji & Symbol Picker',
  description: '''
Find and copy unicode characters, emoji, kaomoji and symbols.''',
  url: ejimoUrl,
);

final luvAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/luv.png',
  overline: 'Design Inspiration',
  title: 'LUV: Design Inspiration',
  description: '''
Endless inspiration for designers, powered by COLOURlovers: colors, palettes, and patterns.''',
  url: luvUrl,
);

final catIdentifierAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/cat_identifier.png',
  overline: 'AI Identifier',
  title: 'Cat Breed Identification App',
  description: '''
Identify cat breeds from photographs using AI.''',
  url: catIdentifierUrl,
);

final textmineAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/textmine.png',
  overline: 'Extract emails, dates & more',
  title: 'TextMine: Text to Data',
  description: '''
Extract emails, phone numbers, dates, and more from any text or file. Fast, accurate, and private.''',
  url: textmineUrl,
);

final clarityAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/clarity.png',
  overline: 'Contrast checker for designers',
  title: 'Clarity: Color Accessibility Check',
  description: '''
Check WCAG accessibility guidelines, verify contrast ratios, and build color palettes with ease.''',
  url: clarityUrl,
);

String get exaboxUrl => switch (Platform.operatingSystem) {
  _ => 'https://exabox.app/',
};

String get hexeeProUrl => switch (Platform.operatingSystem) {
  _ => 'https://hexee.app/',
};

String get paletteConverterUrl => switch (Platform.operatingSystem) {
  'ios' || 'macos' =>
    'https://apps.apple.com/us/app/color-palette-conversion-upc/id6480113031',
  'android' =>
    'https://play.google.com/store/apps/details?id=me.albemala.paletteconverter',
  _ => '',
};

String get wmapUrl => switch (Platform.operatingSystem) {
  'ios' => 'https://apps.apple.com/app/id1481230214',
  'android' => 'https://play.google.com/store/apps/details?id=me.albemala.wmap',
  _ => 'https://wmap.albemala.me/',
};

String get iroIroUrl => switch (Platform.operatingSystem) {
  'ios' || 'macos' =>
    'https://apps.apple.com/us/app/iro-iro-relaxing-color-puzzle/id1563030881/',
  'android' =>
    'https://play.google.com/store/apps/details?id=me.albemala.iro_iro',
  _ => 'https://iro-iro.albemala.me/',
};

String get ejimoUrl => switch (Platform.operatingSystem) {
  'ios' || 'macos' => 'https://apps.apple.com/us/app/ejimo/id1598944603',
  'android' =>
    'https://play.google.com/store/apps/details?id=me.albemala.ejimo',
  _ => 'https://github.com/albemala/emoji-picker',
};

String get luvUrl => switch (Platform.operatingSystem) {
  'ios' ||
  'macos' => 'https://apps.apple.com/us/app/color-picker-luv/id1438312561',
  'android' =>
    'https://play.google.com/store/apps/details?id=me.albemala.luv&hl=en',
  _ => 'https://github.com/albemala/colourlovers-app',
};

String get catIdentifierUrl => switch (Platform.operatingSystem) {
  'ios' || 'macos' =>
    'https://apps.apple.com/us/app/cat-breed-identifier-cat-id/id6749202141',
  'android' =>
    'https://play.google.com/store/apps/details?id=me.albemala.catbreedidentifier',
  _ => '',
};

String get textmineUrl => switch (Platform.operatingSystem) {
  'ios' ||
  'macos' => 'https://apps.apple.com/us/app/textmine-text-to-data/id6754284922',
  _ => '',
};

String get clarityUrl => switch (Platform.operatingSystem) {
  'ios' || 'macos' =>
    'https://apps.apple.com/us/app/color-accessibility-check/id6752328976',
  _ => '',
};

final List<AdData> allAdsData = [
  exaboxAdData,
  hexeeProAdData,
  paletteConverterAdData,
  wmapAdData,
  iroIroAdData,
  // ejimoAdData,
  luvAdData,
  catIdentifierAdData,
  textmineAdData,
  clarityAdData,
];

AdData selectRandomAdData() {
  final random = Random();
  return allAdsData[random.nextInt(allAdsData.length)];
}

class AdView extends StatelessWidget {
  final AdData adData;

  const AdView({
    super.key,
    required this.adData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Row(
          spacing: 16,
          children: [
            ClipOval(
              child: Image.asset(
                adData.iconAssetPath,
                width: 48,
                height: 48,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        adData.overline.toUpperCase(),
                        style: getSubtitleTextStyle(context),
                      ),
                      Text(
                        adData.title,
                        style: getTitleTextStyle(context),
                        softWrap: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(
          adData.description,
          style: getBodyTextStyle(context),
          softWrap: true,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: OutlinedButton(
            onPressed: () {
              unawaited(openUrl(adData.url));
            },
            child: const Text('Learn more'),
          ),
        ),
      ],
    );
  }
}
