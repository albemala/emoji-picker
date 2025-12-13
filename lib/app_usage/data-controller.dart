import 'package:app/app_usage/data-state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_data_storage/flutter_data_storage.dart';

const appUsageDataStoreName = 'app_usage';

class AppUsageDataController extends StoredCubit<AppUsageDataState> {
  factory AppUsageDataController.fromContext(BuildContext _) {
    return AppUsageDataController();
  }

  AppUsageDataController() : super(AppUsageDataState.initial());

  @override
  Future<void> migrateData() async {}

  @override
  String get storeName => appUsageDataStoreName;

  @override
  AppUsageDataState fromMap(Map<String, dynamic> json) {
    return AppUsageDataState.fromMap(json);
  }

  @override
  Map<String, dynamic> toMap(AppUsageDataState state) {
    return state.toMap();
  }

  int get usageCount => state.usageCount;
  set usageCount(int count) => emit(state.copyWith(usageCount: count));

  void incrementUsageCount() =>
      emit(state.copyWith(usageCount: state.usageCount + 1));

  int get glyphCopiedCount => state.glyphCopiedCount;
  set glyphCopiedCount(int count) =>
      emit(state.copyWith(glyphCopiedCount: count));

  void incrementGlyphCopiedCount() =>
      emit(state.copyWith(glyphCopiedCount: state.glyphCopiedCount + 1));
}
