import 'dart:async';

import 'package:emoji_picker/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

final List<AdData> adsData = [
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
                        style: getSubtitleTextStyle(context).copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onTertiaryContainer,
                        ),
                      ),
                      Text(
                        adData.title,
                        style: getTitleTextStyle(context).copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onTertiaryContainer,
                        ),
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
          style: getBodyTextStyle(context).copyWith(
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
          softWrap: true,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: OutlinedButton(
            onPressed: () {
              unawaited(openUrl(adData.url));
            },
            child: Text(
              'Learn more',
              style: getBodyTextStyle(context).copyWith(
                color: Theme.of(context).colorScheme.onTertiaryContainer,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
