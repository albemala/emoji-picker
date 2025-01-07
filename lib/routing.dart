import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  SnackBar snackBar,
) {
  if (!context.mounted) return;
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(snackBar);
}

Future<ReturnType?> openDialog<ReturnType>(
  BuildContext context,
  Widget dialog,
) async {
  if (!context.mounted) return null;
  return showDialog<ReturnType>(
    context: context,
    builder: (_) => dialog,
  );
}

Future<ReturnType?> openBottomSheet<ReturnType>(
  BuildContext context,
  Widget bottomSheet,
) async {
  if (!context.mounted) return null;
  return showModalBottomSheet<ReturnType>(
    context: context,
    builder: (_) => bottomSheet,
  );
}

Future<ReturnType?> openScreen<ReturnType>(
  BuildContext context,
  Widget route, {
  bool fullscreenDialog = false,
}) async {
  if (!context.mounted) return null;
  return Navigator.of(context).push(
    MaterialPageRoute<ReturnType>(
      fullscreenDialog: fullscreenDialog,
      builder: (_) => route,
    ),
  );
}

void closeCurrentView<ReturnType>(
  BuildContext context, [
  ReturnType? result,
]) {
  if (!context.mounted) return;
  Navigator.of(context).pop(result);
}
