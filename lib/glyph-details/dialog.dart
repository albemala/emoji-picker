import 'package:app/glyph-details/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

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
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: SafeArea(child: GlyphDetailsViewCreator()),
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
