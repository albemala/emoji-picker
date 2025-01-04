import 'package:app/glyphs/defines/glyph.dart';
import 'package:equatable/equatable.dart';

class GlyphDetailsState extends Equatable {
  final Glyph? selectedGlyph;
  final bool isGlyphDetailsVisible;

  const GlyphDetailsState({
    required this.selectedGlyph,
    required this.isGlyphDetailsVisible,
  });

  @override
  List<Object?> get props => [
        selectedGlyph,
        isGlyphDetailsVisible,
      ];
}
