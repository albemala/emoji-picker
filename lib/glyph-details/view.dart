import 'package:app/glyph-details/bloc.dart';
import 'package:app/glyphs/functions.dart';
import 'package:app/glyphs/glyph.dart';
import 'package:cross_platform/cross_platform.dart' as cross_platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphDetailsViewBuilder extends StatelessWidget {
  const GlyphDetailsViewBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlyphDetailsBloc, GlyphDetailsState>(
      builder: (context, state) {
        return GlyphDetailsView(
          bloc: context.read<GlyphDetailsBloc>(),
          viewModel: state,
        );
      },
    );
  }
}

class GlyphDetailsView extends StatelessWidget {
  final GlyphDetailsBloc bloc;
  final GlyphDetailsState viewModel;

  const GlyphDetailsView({
    super.key,
    required this.bloc,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    if (!viewModel.isGlyphDetailsVisible || viewModel.selectedGlyph == null) {
      return Container();
    } else {
      final glyph = viewModel.selectedGlyph!;
      return Padding(
        padding: const EdgeInsets.all(21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _GlyphNameView(glyph: glyph),
                ),
                _CloseView(onClose: bloc.hideDetails),
              ],
            ),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _GlyphView(glyph: glyph),
                _CopyGlyphView(
                  onCopy: () {
                    bloc.copyGlyphToClipboard(context, glyph);
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (glyph.unicode.isNotEmpty)
                      _GlyphValueView(
                        title: 'Unicode',
                        value: glyph.unicode,
                        onCopy: () {
                          bloc.copyGlyphUnicodeToClipboard(context, glyph);
                        },
                      ),
                    const SizedBox(width: 16),
                    if (glyph.htmlCode.isNotEmpty)
                      _GlyphValueView(
                        title: 'HTML code',
                        value: glyph.htmlCode,
                        onCopy: () {
                          bloc.copyGlyphHtmlCodeToClipboard(context, glyph);
                        },
                      ),
                  ],
                ),
              ],
            ),
            if (glyph.keywords.isNotEmpty) //
              const SizedBox(height: 16),
            if (glyph.keywords.isNotEmpty) //
              _GlyphKeywordsView(glyph: glyph),
          ],
        ),
      );
    }
  }
}

class _GlyphView extends StatelessWidget {
  final Glyph glyph;

  const _GlyphView({
    required this.glyph,
  });

  @override
  Widget build(BuildContext context) {
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

class _GlyphNameView extends StatelessWidget {
  final Glyph glyph;

  const _GlyphNameView({
    required this.glyph,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      glyph.name,
      style: Theme.of(context).textTheme.titleMedium,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
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
  final Glyph glyph;

  const _GlyphKeywordsView({
    required this.glyph,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        for (final keyword in glyph.keywords)
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

class _CloseView extends StatelessWidget {
  const _CloseView({
    required this.onClose,
  });

  final void Function() onClose;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: const Icon(CupertinoIcons.clear),
      onPressed: onClose,
    );
  }
}
