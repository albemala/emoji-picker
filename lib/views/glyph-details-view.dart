import 'package:app/data/glyphs.dart';
import 'package:cross_platform/cross_platform.dart' as cross_platform;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GlyphDetailsView extends HookConsumerWidget {
  final Glyph? glyph;

  const GlyphDetailsView({
    super.key,
    required this.glyph,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (glyph == null) {
      return Container();
    } else {
      return Material(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    glyph!.char,
                    style: const TextStyle(fontSize: 56),
                  ),
                  const SizedBox(width: 24),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name'.toUpperCase(),
                          style: Theme.of(context).textTheme.caption,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                        Text(
                          glyph!.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Unicode'.toUpperCase(),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        'U+${glyph!.char.runes.first.toRadixString(16).toUpperCase()}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
/*
                      const SizedBox(width: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "HTML code".toUpperCase(),
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(
                            "&#${glyphWithDetails.char.runes.first.toRadixString(10).toUpperCase()};",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
*/
                ],
              ),
              const SizedBox(height: 8),
              Text(
                // TODO this doesn't work well on web
                // TODO change copy on android and ios
                cross_platform.Platform.isMacOS //
                    ? '⌘+C or double-click to copy'
                    : 'Ctrl+C or double-click to copy',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      );
    }
  }
}
