import 'package:app/conductors/preferences-conductor.dart';
import 'package:app/conductors/routing-conductor.dart';
import 'package:app/views/about.dart';
import 'package:app/views/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_management/flutter_state_management.dart';

class TopBarView extends StatelessWidget {
  const TopBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 21, vertical: 24),
      child: Row(
        children: [
          Expanded(
            child: SearchViewCreator(),
          ),
          SizedBox(width: 12),
          ToggleThemeModeButton(),
          ShowAboutViewButton(),
        ],
      ),
    );
  }
}

class ToggleThemeModeButton extends StatelessWidget {
  const ToggleThemeModeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConductorConsumer<PreferencesConductor>(
      builder: (context, preferencesConductor) {
        return SizedBox(
          width: 48,
          height: 48,
          child: IconButton(
            onPressed: () {
              preferencesConductor.toggleThemeMode();
            },
            icon: preferencesConductor.themeMode.value == ThemeMode.light //
                ? const Icon(CupertinoIcons.moon)
                : const Icon(CupertinoIcons.sun_max),
          ),
        );
      },
    );
  }
}

class ShowAboutViewButton extends StatelessWidget {
  const ShowAboutViewButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: IconButton(
        onPressed: () {
          context.getConductor<RoutingConductor>().showDialog(
                (context) => const AlertDialog(
                  clipBehavior: Clip.hardEdge,
                  contentPadding: EdgeInsets.zero,
                  content: AboutViewCreator(),
                ),
              );
        },
        icon: const Icon(CupertinoIcons.info),
      ),
    );
  }
}
