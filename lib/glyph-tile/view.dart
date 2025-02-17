import 'package:app/glyph-data/defines/glyph.dart';
import 'package:app/glyph-tile/functions.dart';
import 'package:app/glyph-tile/view-controller.dart';
import 'package:app/glyph-tile/view-state.dart';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlyphTileViewCreator extends StatefulWidget {
  final Glyph glyph;
  final Widget Function(BuildContext context, Glyph glyph) glyphContentBuilder;

  const GlyphTileViewCreator({
    super.key,
    required this.glyph,
    required this.glyphContentBuilder,
  });

  @override
  State<GlyphTileViewCreator> createState() => _GlyphTileViewCreatorState();
}

class _GlyphTileViewCreatorState extends State<GlyphTileViewCreator> {
  late final GlyphTileViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GlyphTileViewController.fromContext(context);
    _controller.setGlyph(widget.glyph);
  }

  @override
  void didUpdateWidget(covariant GlyphTileViewCreator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.glyph != widget.glyph) {
      _controller.setGlyph(widget.glyph);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _controller,
      child: BlocBuilder<GlyphTileViewController, GlyphTileViewState>(
        builder: (context, state) {
          return GlyphTileView(
            state: state,
            controller: context.read<GlyphTileViewController>(),
            glyphContentView: widget.glyphContentBuilder(context, state.glyph),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
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
      color: state.isSelected
          ? Theme.of(context).colorScheme.tertiaryContainer
          : null,
      child: InkWell(
        onTap: controller.focusNode.requestFocus,
        onDoubleTap: () {
          copyGlyphToClipboard(context, state.glyph);
        },
        focusNode: controller.focusNode,
        onFocusChange: controller.onFocusChange,
        child: glyphContentView,
      ),
    );
  }
}

class SquaredGlyphTileContentView extends StatelessWidget {
  final Glyph glyph;

  const SquaredGlyphTileContentView({
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

class RectangularGlyphTileContentView extends StatelessWidget {
  final Glyph glyph;

  const RectangularGlyphTileContentView({
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
