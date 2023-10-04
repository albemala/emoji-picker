import 'package:app/views/glyph-details.dart';
import 'package:app/views/glyph-list.dart';
import 'package:app/views/top-bar.dart';
import 'package:flutter/material.dart';

class AppContentView extends StatelessWidget {
  const AppContentView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Material(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBarView(),
              Expanded(
                child: GlyphListViewCreator(),
              ),
              GlyphDetailsViewCreator(),
            ],
          ),
        ),
      ),
    );
  }
}
