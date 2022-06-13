import 'package:app/data/glyphs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GlyphDetailsBloc extends StateNotifier<Glyph?> {
  GlyphDetailsBloc() : super(null);

  bool get isVisible => state != null;

  // ignore: use_setters_to_change_properties
  void showDetailsFor(Glyph? glyph) {
    state = glyph;
  }

  void hideDetails() {
    state = null;
  }
}
