import 'package:app/conductors/glyph-actions-conductor.dart';
import 'package:app/conductors/glyph-details-conductor.dart';
import 'package:app/models/glyph.dart';
import 'package:cross_platform/cross_platform.dart' as cross_platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_management/flutter_state_management.dart';
import 'package:super_responsive/super_responsive.dart';

class GlyphDetailsViewCreator extends StatelessWidget {
  const GlyphDetailsViewCreator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConductorConsumer<GlyphDetailsConductor>(
      builder: (context, conductor) {
        return GlyphDetailsView(
          conductor: conductor,
        );
      },
    );
  }
}

class GlyphDetailsView extends StatelessWidget {
  final GlyphDetailsConductor conductor;

  const GlyphDetailsView({
    super.key,
    required this.conductor,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: conductor.isGlyphDetailsVisible,
      builder: (context, isVisible, _) {
        if (!isVisible) {
          return Container();
        } else {
          final glyph = conductor.selectedGlyph.value!;
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(CupertinoIcons.clear),
                      onPressed: conductor.hideDetails,
                    ),
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
                      onCopyGlyph: () {
                        context
                            .getConductor<GlyphActionsConductor>()
                            .copySelectedGlyphToClipboard();
                      },
                    ),
                    _SmallScreenView(
                      glyph: glyph,
                      onCopyGlyph: () {
                        context
                            .getConductor<GlyphActionsConductor>()
                            .copySelectedGlyphToClipboard();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class _LargeScreenView extends StatelessWidget {
  const _LargeScreenView({
    required this.glyph,
    required this.onCopyGlyph,
  });

  final Glyph glyph;
  final void Function() onCopyGlyph;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            _GlyphView(
              glyph: glyph,
              onCopyGlyph: onCopyGlyph,
            ),
            const SizedBox(width: 24),
            Flexible(
              child: _NameView(glyph: glyph),
            ),
            const SizedBox(width: 24),
            _UnicodeView(glyph: glyph),
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

  final Glyph glyph;
  final void Function() onCopyGlyph;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _GlyphView(
              glyph: glyph,
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
              child: _NameView(glyph: glyph),
            ),
            const SizedBox(width: 24),
            _UnicodeView(glyph: glyph),
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
    return SizedBox(
      width: 80,
      height: 80,
      child: IconButton(
        onPressed: onCopyGlyph,
        iconSize: 80,
        padding: EdgeInsets.zero,
        icon: Text(
          glyph.char,
          style: const TextStyle(fontSize: 56),
        ),
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
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          glyph.name,
          style: Theme.of(context).textTheme.titleLarge,
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
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          'U+${glyph.char.runes.first.toRadixString(16).toUpperCase()}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}

// TODO?
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
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          '&#${glyph.char.runes.first.toRadixString(10).toUpperCase()};',
          style: Theme.of(context).textTheme.bodyLarge,
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
    if (cross_platform.Platform.isMobile) {
      return OutlinedButton(
        onPressed: onCopyGlyph,
        child: const Text('Copy'),
      );
    } else /* is desktop */ {
      return Text(
        cross_platform.Platform.isMacOS //
            ? '⌘+C or double-click to copy'
            : 'Ctrl+C or double-click to copy',
        style: Theme.of(context).textTheme.bodySmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
  }
}
