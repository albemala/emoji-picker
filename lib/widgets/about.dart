import 'package:app/about/view.dart';
import 'package:app/routing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutButtonView extends StatelessWidget {
  const AboutButtonView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: IconButton(
        onPressed: () {
          openDialog<void>(
            context,
            const AlertDialog(
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
