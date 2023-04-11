import 'package:app/data/glyphs.dart';
import 'package:app/views/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadGlyphs();

  runApp(
    const ProviderScope(
      child: AppView(),
    ),
  );
}
