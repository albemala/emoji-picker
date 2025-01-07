import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyph-details/view-controller.dart';
import 'package:app/glyph-details/view-state.dart';
import 'package:app/glyph-tile/functions.dart';
import 'package:cross_platform/cross_platform.dart' as cross_platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphDetailsViewCreator extends StatelessWidget {
  const GlyphDetailsViewCreator({
    super.key,
  });

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
      return Shortcuts(
        shortcuts: copyGlyphShortcuts,
        child: Actions(
          actions: {
            CopyGlyphIntent: CopyGlyphAction(context, state.glyph),
          },
          child: _GlyphDetailsContentView(
            state: state,
            controller: controller,
          ),
        ),
      );
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
    return Padding(
      padding: const EdgeInsets.all(21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderView(
            state: state,
            controller: controller,
          ),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _GlyphView(
                state: state,
              ),
              _CopyGlyphView(
                onCopy: () {
                  copyGlyphToClipboard(context, state.glyph);
                },
              ),
              _GlyphValuesView(
                state: state,
                controller: controller,
              ),
            ],
          ),
          if (state.glyph.keywords.isNotEmpty) //
            const SizedBox(height: 16),
          if (state.glyph.keywords.isNotEmpty) //
            _GlyphKeywordsView(
              state: state,
            ),
        ],
      ),
    );
  }
}

class _HeaderView extends StatelessWidget {
  final GlyphDetailsViewState state;
  final GlyphDetailsViewController controller;

  const _HeaderView({
    required this.state,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            state.glyph.name,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(CupertinoIcons.clear),
          onPressed: controller.closeDetailsView,
        ),
      ],
    );
  }
}

class _GlyphView extends StatelessWidget {
  final GlyphDetailsViewState state;

  const _GlyphView({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final glyph = state.glyph;
    return Text(
      glyph.glyph,
      style: getTextStyleForGlyph(glyph).copyWith(
        fontSize: glyph.type == GlyphType.kaomoji ? 32 : 56,
      ),
      overflow: TextOverflow.fade,
      maxLines: 1,
      softWrap: false,
    );
  }
}

class _CopyGlyphView extends StatelessWidget {
  final void Function() onCopy;

  const _CopyGlyphView({
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      spacing: 8,
      children: [
        FilledButton(
          onPressed: onCopy,
          child: const Text('Copy'),
        ),
        if (cross_platform.Platform.isDesktop)
          Text(
            cross_platform.Platform.isMacOS //
                ? 'or ⌘C or double-click to copy'
                : 'or Ctrl C or double-click to copy',
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }
}

class _GlyphValuesView extends StatelessWidget {
  final GlyphDetailsViewState state;
  final GlyphDetailsViewController controller;

  const _GlyphValuesView({
    required this.state,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (state.glyph.unicode.isNotEmpty)
          _GlyphValueView(
            title: 'Unicode',
            value: state.glyph.unicode,
            onCopy: () {
              copyGlyphUnicodeToClipboard(context, state.glyph);
            },
          ),
        const SizedBox(width: 16),
        if (state.glyph.htmlCode.isNotEmpty)
          _GlyphValueView(
            title: 'HTML code',
            value: state.glyph.htmlCode,
            onCopy: () {
              copyGlyphHtmlCodeToClipboard(context, state.glyph);
            },
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
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          InkWell(
            onTap: onCopy,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  CupertinoIcons.doc_on_clipboard,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GlyphKeywordsView extends StatelessWidget {
  final GlyphDetailsViewState state;

  const _GlyphKeywordsView({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        for (final keyword in state.glyph.keywords)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '#$keyword',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}
