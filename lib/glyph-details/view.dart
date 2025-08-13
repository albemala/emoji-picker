import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyph-details/view-controller.dart';
import 'package:app/glyph-details/view-state.dart';
import 'package:app/glyph-tile/functions.dart';
import 'package:app/theme/text.dart';
import 'package:app/ads.dart';
import 'package:cross_platform/cross_platform.dart' as cross_platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphDetailsViewCreator extends StatelessWidget {
  const GlyphDetailsViewCreator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlyphDetailsViewController>(
      create: GlyphDetailsViewController.fromContext,
      child: BlocBuilder<GlyphDetailsViewController, GlyphDetailsViewState>(
        builder: (context, state) {
          return GlyphDetailsView(
            controller: context.read<GlyphDetailsViewController>(),
            state: state,
          );
        },
      ),
    );
  }
}

class GlyphDetailsView extends StatelessWidget {
  final GlyphDetailsViewController controller;
  final GlyphDetailsViewState state;

  const GlyphDetailsView({
    super.key,
    required this.controller,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (state.glyph == unknownGlyph) {
      return Container();
    } else {
      return _GlyphDetailsContentView(state: state, controller: controller);
    }
  }
}

class _GlyphDetailsContentView extends StatelessWidget {
  final GlyphDetailsViewState state;
  final GlyphDetailsViewController controller;

  const _GlyphDetailsContentView({
    required this.state,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 24,
      children: [
        // Hero Section - Glyph Display
        _SectionCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // spacing: 16,
            children: [
              _GlyphView(state: state),
              Text(
                state.glyph.name,
                style: getHeadlineTextStyle(context).copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryFixed,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        // Primary Action Section
        _CopyGlyphView(controller: controller),

        Row(
          children: [
            OutlinedButton.icon(
              onPressed: controller.toggleFavorite,
              icon: Icon(
                controller.state.isFavorite
                    ? CupertinoIcons.star_fill
                    : CupertinoIcons.star,
              ),
              label: Text(
                controller.state.isFavorite
                    ? 'Remove from Favorites'
                    : 'Add to Favorites',
              ),
            ),
          ],
        ),

        // Technical Information Section
        if (state.glyph.unicode.isNotEmpty || state.glyph.htmlCode.isNotEmpty)
          Row(
            spacing: 16,
            children: [
              if (state.glyph.unicode.isNotEmpty)
                _GlyphValueView(
                  title: 'Unicode',
                  value: state.glyph.unicode,
                  onCopy: () {
                    copyGlyphUnicodeToClipboard(context, state.glyph);
                  },
                ),
              if (state.glyph.htmlCode.isNotEmpty)
                _GlyphValueView(
                  title: 'HTML Code',
                  value: state.glyph.htmlCode,
                  onCopy: () {
                    copyGlyphHtmlCodeToClipboard(context, state.glyph);
                  },
                ),
            ],
          ),

        // Keywords Section
        if (state.glyph.keywords.isNotEmpty)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                'Keywords'.toUpperCase(),
                style: getSubtitleTextStyle(context),
              ),
              _GlyphKeywordsView(state: state),
            ],
          ),

        // Ad Section
        _SectionCard(child: AdView(adData: state.adData)),
      ],
    );
  }
}

class _GlyphView extends StatelessWidget {
  final GlyphDetailsViewState state;

  const _GlyphView({required this.state});

  @override
  Widget build(BuildContext context) {
    final glyph = state.glyph;
    return Text(
      glyph.glyph,
      style: getTextStyleForGlyph(
        glyph,
      ).copyWith(fontSize: glyph.type == GlyphType.kaomoji ? 48 : 72),
      overflow: TextOverflow.fade,
      maxLines: 1,
      softWrap: false,
    );
  }
}

class _CopyGlyphView extends StatelessWidget {
  final GlyphDetailsViewController controller;

  const _CopyGlyphView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        FilledButton.icon(
          onPressed: () => controller.copyGlyph(context),
          icon: Icon(
            CupertinoIcons.doc_on_clipboard,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 18,
          ),
          label: Text(
            'Copy',
            style: getTitleTextStyle(context).copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          ),
        ),
        if (cross_platform.Platform.isDesktop)
          Text(
            cross_platform.Platform.isMacOS ? 'or ⌘C' : 'or Ctrl C',
            style: getBodyTextStyle(context),
          ),
      ],
    );
  }
}

class _GlyphValueView extends StatelessWidget {
  final String title;
  final String value;
  final void Function() onCopy;

  const _GlyphValueView({
    required this.title,
    required this.value,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          title.toUpperCase(),
          style: getSubtitleTextStyle(context),
        ),
        OutlinedButton.icon(
          onPressed: onCopy,
          label: Text(
            value,
          ),
          icon: const Icon(
            CupertinoIcons.doc_on_clipboard,
          ),
        ),
      ],
    );
  }
}

class _GlyphKeywordsView extends StatelessWidget {
  final GlyphDetailsViewState state;

  const _GlyphKeywordsView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final keyword in state.glyph.keywords)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryFixed,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '#$keyword',
              style: getBodyTextStyle(context).copyWith(
                color: Theme.of(context).colorScheme.onTertiaryFixed,
              ),
            ),
          ),
      ],
    );
  }
}

/// Reusable card container widget for consistent section styling
class _SectionCard extends StatelessWidget {
  final Widget child;

  const _SectionCard({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryFixed,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
