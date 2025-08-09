import 'package:app/glyph-details/view.dart';
import 'package:app/routing.dart';
import 'package:flutter/material.dart';

class GlyphDetailsDialog extends StatelessWidget {
  const GlyphDetailsDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: GlyphDetailsViewCreator(),
      ),
    );
  }
}

Future<void> showGlyphDetailsDialog(BuildContext context) async {
  await openScreen<void>(
    context,
    const GlyphDetailsDialog(),
    fullscreenDialog: true,
  );
}
