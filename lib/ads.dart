import 'dart:io';
import 'dart:math';

import 'package:app/theme/text.dart';
import 'package:app/urls/functions.dart';
import 'package:flutter/material.dart';

class AdData {
  final String iconAssetPath;
  final String overline;
  final String title;
  final String description;
  final String Function() url;

  const AdData({
    required this.iconAssetPath,
    required this.overline,
    required this.title,
    required this.description,
    required this.url,
  });
}

const exaboxAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/exabox.png',
  overline: 'Your coding companion',
  title: 'Exabox: Essential tools for developers',
  description: '''
The ultimate developer toolkit in your pocket. Transform, inspect, and manipulate data with 30+ essential utilities.''',
  url: getExaboxUrl,
);

const hexeeProAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/hexee-pro.png',
  overline: 'Your color workspace',
  title: 'Hexee Pro: Advanced palette & color tools',
  description: '''
Advanced color tools for designers and artists in one unified workspace. Create, edit, and organize palettes, fine-tune colors, and check accessibility.''',
  url: getHexeeProUrl,
);

const paletteConverterAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/upc.png',
  overline: 'Color palettes, simplified',
  title: 'Universal Palette Converter',
  description: '''
Universal Palette Converter is the ultimate solution for managing and converting color palettes across various formats.''',
  url: getPaletteConverterUrl,
);

const wmapAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/wmap.png',
  overline: 'Your world, your wallpaper',
  title: 'WMap: Map Wallpapers & Backgrounds',
  description: '''
Create beautiful, minimal, custom map wallpapers and backgrounds for your phone or tablet.''',
  url: getWmapUrl,
);

const iroIroAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/iro-iro.png',
  overline: 'Color sorting game',
  title: 'Iro-Iro: Relaxing Color Puzzle',
  description: '''
Arrange colors to form amazing patterns in this relaxing colour puzzle game!''',
  url: getIroIroUrl,
);

const ejimoAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/ejimo.png',
  overline: 'Characters at your fingertips',
  title: 'Ejimo: Emoji & Symbol Picker',
  description: '''
Find and copy unicode characters, emoji, kaomoji and symbols with Ejimo.''',
  url: getEjimoUrl,
);

const luvAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/luv.png',
  overline: 'Design Inspiration',
  title: 'LUV: Design Inspiration',
  description: '''
Endless inspiration for designers, powered by COLOURlovers: colors, palettes, and patterns.''',
  url: getLuvUrl,
);

const catIdentifierAdData = AdData(
  iconAssetPath: 'assets/other_apps_icons/cat_identifier.png',
  overline: 'AI Identifier',
  title: 'Cat Breed Identification App',
  description: '''
Identify cat breeds from photographs using AI.''',
  url: getCatIdentifierUrl,
);

String getExaboxUrl() => switch (Platform.operatingSystem) {
  _ => 'https://exabox.app/?ref=emoji_picker',
};

String getHexeeProUrl() => switch (Platform.operatingSystem) {
  _ => 'https://hexee.app/?ref=emoji_picker',
};

String getPaletteConverterUrl() => switch (Platform.operatingSystem) {
  'ios' || 'macos' =>
    'https://apps.apple.com/us/app/color-palette-conversion-upc/id6480113031',
  'android' =>
    'https://play.google.com/store/apps/details?id=me.albemala.paletteconverter',
  _ => '',
};

String getWmapUrl() => switch (Platform.operatingSystem) {
  'ios' => 'https://apps.apple.com/app/id1481230214',
  'android' => 'https://play.google.com/store/apps/details?id=me.albemala.wmap',
  _ => 'https://wmap.albemala.me/?ref=emoji_picker',
};

String getIroIroUrl() => switch (Platform.operatingSystem) {
  'ios' || 'macos' =>
    'https://apps.apple.com/us/app/iro-iro-relaxing-color-puzzle/id1563030881/',
  'android' =>
    'https://play.google.com/store/apps/details?id=me.albemala.iro_iro',
  _ => 'https://iro-iro.albemala.me/?ref=emoji_picker',
};

String getEjimoUrl() => switch (Platform.operatingSystem) {
  'ios' || 'macos' => 'https://apps.apple.com/us/app/ejimo/id1598944603',
  'android' =>
    'https://play.google.com/store/apps/details?id=me.albemala.ejimo',
  _ => 'https://github.com/albemala/emoji-picker',
};

String getLuvUrl() => switch (Platform.operatingSystem) {
  'ios' || 'macos' =>
    'https://play.google.com/store/apps/details?id=me.albemala.luv&hl=en',
  'android' =>
    'https://play.google.com/store/apps/details?id=me.albemala.luv&hl=en',
  _ => 'https://github.com/albemala/colourlovers-app',
};

String getCatIdentifierUrl() => switch (Platform.operatingSystem) {
  'ios' || 'macos' =>
    'https://apps.apple.com/us/app/cat-breed-identifier-cat-id/id6749202141',
  'android' =>
    'https://play.google.com/store/apps/details?id=me.albemala.catbreedidentifier',
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
              openUrl(adData.url());
            },
            child: const Text('Learn more'),
          ),
        ),
      ],
    );
  }
}
