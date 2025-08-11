import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedTabDataController extends Cubit<void> implements TickerProvider {
  late final TabController tabController = TabController(
    length: 4,
    vsync: this,
  );

  factory SelectedTabDataController.fromContext(BuildContext context) {
    return SelectedTabDataController();
  }

  SelectedTabDataController() : super(null);

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
