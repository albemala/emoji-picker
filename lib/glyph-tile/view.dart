import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyph-tile/view-controller.dart';
import 'package:app/glyph-tile/view-state.dart';
import 'package:app/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphTileViewCreator extends StatelessWidget {
  final Glyph glyph;
  final Widget Function(Glyph glyph) glyphContentBuilder;

  const GlyphTileViewCreator({
    super.key,
    required this.glyph,
    required this.glyphContentBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlyphTileViewController>(
      key: ValueKey(glyph),
      create: (context) => GlyphTileViewController.fromContext(context, glyph),
      child: BlocBuilder<GlyphTileViewController, GlyphTileViewState>(
        builder: (context, state) {
          return GlyphTileView(
            state: state,
            controller: context.read<GlyphTileViewController>(),
            glyphContentView: glyphContentBuilder(state.glyph),
          );
        },
      ),
    );
  }
}

class GlyphTileView extends StatelessWidget {
  final GlyphTileViewState state;
  final GlyphTileViewController controller;
  final Widget glyphContentView;

  const GlyphTileView({
    super.key,
    required this.state,
    required this.controller,
    required this.glyphContentView,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: state.isSelected
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.tertiaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: state.isFocused
            ? BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              )
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () => controller.onTap(context),
        onDoubleTap: () => controller.onDoubleTap(context),
        onLongPress: () => controller.onLongPress(context),
        focusNode: controller.focusNode,
        onFocusChange: controller.onFocusChange,
        child: glyphContentView,
      ),
    );
  }
}

class SquaredGlyphTileContentView extends StatelessWidget {
  final Glyph glyph;

  const SquaredGlyphTileContentView({super.key, required this.glyph});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        glyph.glyph,
        style: getTextStyleForGlyph(glyph).copyWith(fontSize: 32),
      ),
    );
  }
}

class RectangularGlyphTileContentView extends StatelessWidget {
  final Glyph glyph;

  const RectangularGlyphTileContentView({super.key, required this.glyph});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        glyph.glyph,
        style: getTextStyleForGlyph(glyph).copyWith(fontSize: 18),
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: false,
      ),
    );
  }
}
