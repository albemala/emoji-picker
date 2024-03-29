import 'package:flutter/material.dart';

class GlyphGroupTitleView extends StatelessWidget {
  final String title;

  const GlyphGroupTitleView({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 8),
        child: Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
