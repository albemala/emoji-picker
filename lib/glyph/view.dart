import 'package:app/glyph/functions.dart';
import 'package:app/glyph/view-controller.dart';
import 'package:app/glyph/view-state.dart';
import 'package:app/glyphs/defines/glyph.dart';
import 'package:app/glyphs/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphViewCreator extends StatelessWidget {
  final Glyph glyph;
  final Widget Function(BuildContext context, Glyph glyph) glyphContentBuilder;

  const GlyphViewCreator({
    super.key,
    required this.glyph,
    required this.glyphContentBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlyphViewController>(
      create: (context) => GlyphViewController.fromContext(
        context,
        glyph,
      ),
      child: BlocBuilder<GlyphViewController, GlyphViewState>(
        builder: (context, state) {
          return GlyphView(
            state: state,
            controller: context.read<GlyphViewController>(),
            glyphContentView: glyphContentBuilder(context, state.glyph),
          );
        },
      ),
    );
  }
}

class GlyphView extends StatelessWidget {
  final GlyphViewState state;
  final GlyphViewController controller;
  final Widget glyphContentView;

  const GlyphView({
    super.key,
    required this.state,
    required this.controller,
    required this.glyphContentView,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      child: InkWell(
        onTap: controller.focusNode.requestFocus,
        onDoubleTap: () {
          copyGlyphToClipboard(context, state.glyph);
        },
        focusNode: controller.focusNode,
        focusColor: Theme.of(context).colorScheme.tertiary,
        onFocusChange: controller.onFocusChange,
        child: glyphContentView,
      ),
    );
  }
}

class SquaredGlyphContentView extends StatelessWidget {
  final Glyph glyph;

  const SquaredGlyphContentView({
    super.key,
    required this.glyph,
  });

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

class RectangularGlyphContentView extends StatelessWidget {
  final Glyph glyph;

  const RectangularGlyphContentView({
    super.key,
    required this.glyph,
  });

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
