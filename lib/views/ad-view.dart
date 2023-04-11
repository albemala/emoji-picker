import 'package:flutter/material.dart';

class AdView extends StatelessWidget {
  final String iconAssetPath;
  final String overline;
  final String title;
  final String description;
  final void Function() onLearnMore;

  const AdView({
    super.key,
    required this.iconAssetPath,
    required this.overline,
    required this.title,
    required this.description,
    required this.onLearnMore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          iconAssetPath,
          width: 48,
          height: 48,
          filterQuality: FilterQuality.medium,
        ),
        const SizedBox(height: 16),
        Text(
          overline.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: onLearnMore,
            child: const Text('Learn more'),
          ),
        ),
      ],
    );
  }
}
