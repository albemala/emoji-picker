import 'package:flutter/material.dart';

class GroupTitleView extends StatelessWidget {
  final String title;

  const GroupTitleView({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
