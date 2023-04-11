import 'package:app/data/glyphs.dart';
import 'package:app/intents-actions.dart';
import 'package:app/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GlyphView extends HookConsumerWidget {
  final Glyph glyph;

  const GlyphView({
    super.key,
    required this.glyph,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    return Material(
      type: MaterialType.card,
      child: InkWell(
        onTap: focusNode.requestFocus,
        onDoubleTap: () {
          CopyGlyphAction(context, glyph.char).invoke(const CopyGlyphIntent());
        },
        focusNode: focusNode,
        focusColor: Theme.of(context).colorScheme.secondary,
        onFocusChange: (isFocused) {
          if (isFocused) {
            ref.read(glyphDetailsProvider.notifier).showDetailsFor(glyph);
          }
          // else {
          //   ref.read(glyphDetailsProvider.notifier).hideDetails();
          // }
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
