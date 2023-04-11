import 'package:flutter/material.dart';
import 'package:slivers/slivers.dart';

class GlyphGroupTitleView extends StatelessWidget {
  final String title;

  const GlyphGroupTitleView({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverBox(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
