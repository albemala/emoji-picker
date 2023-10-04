import 'package:app/conductors/glyph-details-conductor.dart';
import 'package:app/conductors/routing-conductor.dart';
import 'package:app/functions/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_management/flutter_state_management.dart';

class GlyphActionsConductor extends Conductor {
  factory GlyphActionsConductor.fromContext(BuildContext context) {
    return GlyphActionsConductor(
      context.getConductor<RoutingConductor>(),
      context.getConductor<GlyphDetailsConductor>(),
    );
  }

  final RoutingConductor _routingConductor;
  final GlyphDetailsConductor _glyphDetailsConductor;

  GlyphActionsConductor(
    this._routingConductor,
    this._glyphDetailsConductor,
  );

  @override
  void dispose() {}

  Future<void> copySelectedGlyphToClipboard() async {
    final char = _glyphDetailsConductor.selectedGlyph.value?.char ?? '';
    if (char.isEmpty) return;

    await copyToClipboard(char);

    _routingConductor.showSnackBar(
      (context) => SnackBar(
        content: Row(
          children: [
            Text(
              char,
            ),
            const Text(
              ' copied to clipboard',
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        width: 240,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
