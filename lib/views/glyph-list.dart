import 'package:app/providers.dart';
import 'package:app/utils/math.dart';
import 'package:app/views/ads.dart';
import 'package:app/views/glyph-group-list.dart';
import 'package:app/views/glyph-group-title.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

class GlyphListView extends HookConsumerWidget {
  const GlyphListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visibleGlyphs = ref.watch(visibleGlyphsProvider);
    return Material(
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      elevation: Theme.of(context).brightness == Brightness.light ? 1 : 12,
      child: CustomScrollView(
        slivers: visibleGlyphs.entries.map((entry) {
          return MultiSliver(
            children: [
              GlyphGroupTitleView(title: entry.key),
              GlyphGroupListView(glyphs: entry.value),
              const _AdView(),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _AdView extends StatelessWidget {
  const _AdView();

  @override
  Widget build(BuildContext context) {
    // randomize which ad to show
    final number = randomInt(1, 120);
    if (isBetween(number, 1, 3)) {
      return const _AdContainerView(
        child: ExaboxAdView(),
      );
    }
    if (isBetween(number, 11, 13)) {
      return const _AdContainerView(
        child: HexeeProAdView(),
      );
    }
    if (isBetween(number, 21, 23)) {
      return const _AdContainerView(
        child: WMapAdView(),
      );
    }
    if (isBetween(number, 31, 33)) {
      return const _AdContainerView(
        child: IroIronAdView(),
      );
    }
    return const SizedBox();
  }
}

class _AdContainerView extends StatelessWidget {
  final Widget child;

  const _AdContainerView({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 2,
          child: Material(),
        ),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
