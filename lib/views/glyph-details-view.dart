import 'dart:io';

import 'package:app/data/glyphs.dart';
import 'package:cross_platform/cross_platform.dart' as cross_platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:super_responsive/super_responsive.dart';

class GlyphDetailsView extends HookConsumerWidget {
  final Glyph? glyph;
  final void Function() onCopyGlyph;
  final void Function() onClose;

  const GlyphDetailsView({
    super.key,
    required this.glyph,
    required this.onCopyGlyph,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (glyph == null) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(CupertinoIcons.clear),
                onPressed: onClose,
              ),
            ),
            ResponsiveWidget(
              followsScreenWidth: false,
              breakpoints: Breakpoints(
                first: double.maxFinite,
                second: 480,
              ),
              children: [
                _LargeScreenView(
                  glyph: glyph,
                  onCopyGlyph: onCopyGlyph,
                ),
                _SmallScreenView(
                  glyph: glyph,
                  onCopyGlyph: onCopyGlyph,
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}

class _LargeScreenView extends StatelessWidget {
  const _LargeScreenView({
    required this.glyph,
    required this.onCopyGlyph,
  });

  final Glyph? glyph;
  final void Function() onCopyGlyph;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            _GlyphView(
              glyph: glyph!,
              onCopyGlyph: onCopyGlyph,
            ),
            const SizedBox(width: 24),
            Flexible(
              child: _NameView(glyph: glyph!),
            ),
            const SizedBox(width: 24),
            _UnicodeView(glyph: glyph!),
            // const SizedBox(width: 24),
            // _HtmlCodeView(glyph: glyph!),
            const SizedBox(width: 56),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: _CopyView(
            onCopyGlyph: onCopyGlyph,
          ),
        ),
      ],
    );
  }
}

class _SmallScreenView extends StatelessWidget {
  const _SmallScreenView({
    required this.glyph,
    required this.onCopyGlyph,
  });

  final Glyph? glyph;
  final void Function() onCopyGlyph;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _GlyphView(
              glyph: glyph!,
              onCopyGlyph: onCopyGlyph,
            ),
            const SizedBox(width: 16),
            Flexible(
              child: _CopyView(
                onCopyGlyph: onCopyGlyph,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Flexible(
              child: _NameView(glyph: glyph!),
            ),
            const SizedBox(width: 24),
            _UnicodeView(glyph: glyph!),
            // const SizedBox(width: 24),
            // _HtmlCodeView(glyph: glyph!),
          ],
        ),
      ],
    );
  }
}

class _GlyphView extends StatelessWidget {
  final Glyph glyph;
  final void Function() onCopyGlyph;

  const _GlyphView({
    required this.glyph,
    required this.onCopyGlyph,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onCopyGlyph,
      iconSize: 80,
      padding: EdgeInsets.zero,
      icon: Text(
        glyph.char,
        style: const TextStyle(fontSize: 56),
      ),
    );
  }
}

class _NameView extends StatelessWidget {
  final Glyph glyph;

  const _NameView({
    required this.glyph,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name'.toUpperCase(),
          style: Theme.of(context).textTheme.caption,
        ),
        Text(
          glyph.name,
          style: Theme.of(context).textTheme.headline6,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _UnicodeView extends StatelessWidget {
  final Glyph glyph;

  const _UnicodeView({
    required this.glyph,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Unicode'.toUpperCase(),
          style: Theme.of(context).textTheme.caption,
        ),
        Text(
          'U+${glyph.char.runes.first.toRadixString(16).toUpperCase()}',
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}

class _HtmlCodeView extends StatelessWidget {
  final Glyph glyph;

  const _HtmlCodeView({
    required this.glyph,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HTML code'.toUpperCase(),
          style: Theme.of(context).textTheme.caption,
        ),
        Text(
          '&#${glyph.char.runes.first.toRadixString(10).toUpperCase()};',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}

class _CopyView extends StatelessWidget {
  final void Function() onCopyGlyph;

  const _CopyView({
    required this.onCopyGlyph,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || Platform.isAndroid) {
      return OutlinedButton(
        onPressed: onCopyGlyph,
        child: const Text('Copy'),
      );
    } else {
      return Text(
        // TODO this doesn't work well on web
        cross_platform.Platform.isMacOS //
            ? '⌘+C or double-click to copy'
            : 'Ctrl+C or double-click to copy',
        style: Theme.of(context).textTheme.caption,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
  }
}
