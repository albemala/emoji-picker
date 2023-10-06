import 'package:app/conductors/routing-conductor.dart';
import 'package:app/functions/clipboard.dart';
import 'package:app/models/glyph.dart';
import 'package:app/widgets/snack-bar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_state_management/flutter_state_management.dart';

class GlyphDetailsConductor extends Conductor {
  factory GlyphDetailsConductor.fromContext(BuildContext context) {
    return GlyphDetailsConductor(
      context.getConductor<RoutingConductor>(),
    );
  }

  final RoutingConductor _routingConductor;

  final selectedGlyph = ValueNotifier<Glyph?>(null);

  final isGlyphDetailsVisible = ValueNotifier<bool>(false);

  GlyphDetailsConductor(
    this._routingConductor,
  ) {
    selectedGlyph.addListener(updateIsGlyphDetailsVisible);
  }

  @override
  void dispose() {
    selectedGlyph.removeListener(updateIsGlyphDetailsVisible);

    selectedGlyph.dispose();
    isGlyphDetailsVisible.dispose();
  }

  void showDetailsForGlyph(Glyph? glyph) {
    selectedGlyph.value = glyph;
  }

  void hideDetails() {
    selectedGlyph.value = null;
  }

  void updateIsGlyphDetailsVisible() {
    isGlyphDetailsVisible.value = selectedGlyph.value != null;
  }

  Future<void> copySelectedGlyphToClipboard() async {
    if (selectedGlyph.value == null) return;
    await copyGlyphToClipboard(selectedGlyph.value!);
  }

  Future<void> copyGlyphToClipboard(Glyph glyph) async {
    await copyToClipboard(glyph.glyph);
    _routingConductor.showSnackBar(
      (context) => createCopiedToClipboardSnackBar(glyph.glyph),
    );
  }

  Future<void> copyGlyphUnicodeToClipboard(Glyph glyph) async {
    await copyToClipboard(glyph.unicode);
    _routingConductor.showSnackBar(
      (context) => createCopiedToClipboardSnackBar(glyph.unicode),
    );
  }

  Future<void> copyGlyphHtmlCodeToClipboard(Glyph glyph) async {
    await copyToClipboard(glyph.htmlCode);
    _routingConductor.showSnackBar(
      (context) => createCopiedToClipboardSnackBar(glyph.htmlCode),
    );
  }
}
