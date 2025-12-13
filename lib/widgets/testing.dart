import 'package:app/routing.dart';
import 'package:app/testing/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestingButtonView extends StatelessWidget {
  const TestingButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: IconButton(
        onPressed: () async {
          await openDialog<void>(
            context,
            const AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: TestingViewCreator(),
            ),
          );
        },
        icon: const Icon(CupertinoIcons.wrench),
      ),
    );
  }
}
