import 'package:app/conductors/glyph-details-conductor.dart';
import 'package:app/defines/glyphs.dart';
import 'package:app/models/glyph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_management/flutter_state_management.dart';

class GlyphViewConductor extends Conductor {
  factory GlyphViewConductor.fromContext(BuildContext context) {
    return GlyphViewConductor(
      context.getConductor<GlyphDetailsConductor>(),
    );
  }

  final GlyphDetailsConductor _glyphDetailsConductor;

  final focusNode = FocusNode();

  GlyphViewConductor(this._glyphDetailsConductor);

  @override
  void dispose() {
    focusNode.dispose();
  }

  void onFocusChange(bool isFocused, Glyph glyph) {
    if (isFocused) {
      _glyphDetailsConductor.showDetailsForGlyph(glyph);
    } else {
      _glyphDetailsConductor.hideDetails();
    }
  }
}

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
    return ConductorCreator(
      create: GlyphViewConductor.fromContext,
      child: ConductorConsumer<GlyphViewConductor>(
        builder: (context, conductor) {
          return GlyphView(
            glyph: glyph,
            conductor: conductor,
            glyphContentView: glyphContentBuilder(context, glyph),
          );
        },
      ),
    );
  }
}

class GlyphView extends StatelessWidget {
  final Glyph glyph;
  final GlyphViewConductor conductor;
  final Widget glyphContentView;

  const GlyphView({
    super.key,
    required this.glyph,
    required this.conductor,
    required this.glyphContentView,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      child: InkWell(
        onTap: conductor.focusNode.requestFocus,
        onDoubleTap: () {
          context
              .getConductor<GlyphDetailsConductor>()
              .copySelectedGlyphToClipboard();
        },
        focusNode: conductor.focusNode,
        focusColor: Theme.of(context).colorScheme.tertiary,
        onFocusChange: (isFocused) {
          conductor.onFocusChange(isFocused, glyph);
        },
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
