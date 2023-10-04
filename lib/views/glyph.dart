import 'package:app/conductors/glyph-actions-conductor.dart';
import 'package:app/conductors/glyph-details-conductor.dart';
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

  const GlyphViewCreator({
    super.key,
    required this.glyph,
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
          );
        },
      ),
    );
  }
}

class GlyphView extends StatelessWidget {
  final Glyph glyph;
  final GlyphViewConductor conductor;

  const GlyphView({
    super.key,
    required this.glyph,
    required this.conductor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      child: InkWell(
        onTap: conductor.focusNode.requestFocus,
        onDoubleTap: () {
          context
              .getConductor<GlyphActionsConductor>()
              .copySelectedGlyphToClipboard();
        },
        focusNode: conductor.focusNode,
        focusColor: Theme.of(context).colorScheme.secondary,
        onFocusChange: (isFocused) {
          conductor.onFocusChange(isFocused, glyph);
        },
        child: Center(
          child: Text(
            glyph.char,
            style: const TextStyle(fontSize: 32),
          ),
        ),
      ),
    );
  }
}
