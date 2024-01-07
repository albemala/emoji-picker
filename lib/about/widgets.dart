import 'package:app/about/view.dart';
import 'package:app/routing/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OpenAboutView extends StatelessWidget {
  const OpenAboutView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: IconButton(
        onPressed: () {
          openDialog(
            context,
            const AlertDialog(
              clipBehavior: Clip.hardEdge,
              contentPadding: EdgeInsets.zero,
              content: AboutViewBuilder(),
            ),
          );
        },
        icon: const Icon(CupertinoIcons.info),
      ),
    );
  }
}
