import 'package:app/purchases/data-state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_data_storage/flutter_data_storage.dart';

const purchasesDataStoreName = 'purchases';

class PurchasesDataController extends StoredCubit<PurchasesDataState> {
  factory PurchasesDataController.fromContext(BuildContext _) {
    return PurchasesDataController();
  }

  PurchasesDataController()
    : super(
        PurchasesDataState.initial(),
        dataStore: DataStore(
          storeName: purchasesDataStoreName,
          store: SharedPreferencesStore(storeName: purchasesDataStoreName),
        ),
      );

  @override
  Future<void> migrateData() async {
    if (await dataStore.dataExists) return;
    await dataStore.writeImmediately(PurchasesDataState.initial().toMap());
  }

  @override
  String get storeName => purchasesDataStoreName;

  @override
  PurchasesDataState fromMap(Map<String, dynamic> json) {
    return PurchasesDataState.fromMap(json);
  }

  @override
  Map<String, dynamic> toMap(PurchasesDataState state) {
    return state.toMap();
  }

  bool get isLifetimeFreeUser => state.isLifetimeFreeUser;
  set isLifetimeFreeUser(bool value) =>
      emit(state.copyWith(isLifetimeFreeUser: value));
}
