# Code Guidelines

## Data State Classes

### Definition
Data state classes define immutable application state using Equatable for value equality.

**Rules:**
- Extend `Equatable` for value-based equality comparison
- Annotate with `@immutable`
- All properties are `final` and `required`
- Implement `copyWith()` for immutable updates
- Override `props` getter with all properties
- Include `toMap()` and `fromMap()` for persistence
- Create `initial()` factory constructor

**Example:**
```dart
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

@immutable
class UserDataState extends Equatable {
  final int id;
  final String name;
  final bool isActive;
  final IList<int> tags;
  final EnumType status;

  const UserDataState({
    required this.id,
    required this.name,
    required this.isActive,
    required this.tags,
    required this.status,
  });

  @override
  List<Object> get props => [id, name, isActive, tags, status];

  UserDataState copyWith({
    int? id,
    String? name,
    bool? isActive,
    IList<int>? tags,
    EnumType? status,
  }) {
    return UserDataState(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      tags: tags ?? this.tags,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isActive': isActive,
      'tags': tags.unlock,
      'status': status.name,
    };
  }

  factory UserDataState.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        'id': final int id,
        'name': final String name,
        'isActive': final bool isActive,
        'tags': final List<dynamic> tags,
        'status': final String status,
      } =>
        UserDataState(
          id: id,
          name: name,
          isActive: isActive,
          tags: IList(tags.cast<int>()),
          status: EnumType.values.byName(status),
        ),
      _ => UserDataState.initial(),
    };
  }

  factory UserDataState.initial() {
    return const UserDataState(
      id: 0,
      name: '',
      isActive: true,
      tags: IList.empty(),
      status: EnumType.active,
    );
  }
}

enum EnumType {
  active,
  inactive,
  pending,
}
```

**Key Points:**
- Collections use `IList<T>` and `IMap<K,V>` from `fast_immutable_collections`
- Enums stored as `.name` string in `toMap()`, restored with `EnumType.values.byName()`
- Use pattern matching in `fromMap()` for type-safe deserialization
- Convert dynamic collections: `IList(tags.cast<int>())`

---

## Data Controllers

### Definition
Data controllers manage state persistence using `StoredCubit` from `flutter_data_storage`.

**Rules:**
- Extend `StoredCubit<DataState>` for persistent data
- Factory constructor: `fromContext(BuildContext)` reads from context
- Constructor accepts optional `DataStore? dataStore` for testing
- Implement `storeName`, `fromMap()`, `toMap()`, `migrateData()`
- Generate getters/setters for each state property

**Example:**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_data_storage/flutter_data_storage.dart';

import 'data-state.dart';

const userDataStoreName = 'user_data';

class UserDataController extends StoredCubit<UserDataState> {
  factory UserDataController.fromContext(BuildContext context) {
    return UserDataController();
  }

  UserDataController({
    DataStore? dataStore,
  }) : super(
          UserDataState.initial(),
          dataStore: dataStore,
  );

  @override
  Future<void> migrateData() async {}

  @override
  String get storeName => userDataStoreName;

  @override
  UserDataState fromMap(Map<String, dynamic> json) {
    return UserDataState.fromMap(json);
  }

  @override
  Map<String, dynamic> toMap(UserDataState state) {
    return state.toMap();
  }

  int get id => state.id;
  set id(int value) => emit(state.copyWith(id: value));

  String get name => state.name;
  set name(String value) => emit(state.copyWith(name: value));

  bool get isActive => state.isActive;
  set isActive(bool value) => emit(state.copyWith(isActive: value));

  IList<int> get tags => state.tags;
  set tags(IList<int> value) => emit(state.copyWith(tags: value));

  EnumType get status => state.status;
  set status(EnumType value) => emit(state.copyWith(status: value));
}
```

### Registration in `main.dart`

Data controllers are registered in `lib/main.dart` using `MultiBlocProvider`:

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: const [
        BlocProvider(
          create: PreferencesDataController.fromContext,
          lazy: false,
        ),
        BlocProvider(
          create: UserDataController.fromContext,
          lazy: false,
        ),
      ],
      child: const AppViewCreator(),
    ),
  );
}
```

**Key Points:**
- Use `lazy: false` to ensure controllers are initialized at app startup
- Controllers are accessible via `context.read<DataController>()`
- Setters use `emit(state.copyWith(...))` for state updates

---

## View State Classes

### Definition
View state classes define immutable UI state using Equatable for value equality. They are separate from data state and only contain properties needed for display.

**Rules:**
- Extend `Equatable` for value-based equality comparison
- Annotate with `@immutable`
- All properties are `final` and `required`
- Implement `copyWith()` for immutable updates
- Override `props` getter with all properties
- Create `initial()` factory constructor
- No `toMap()`/`fromMap()` needed (view state is not persisted)

**Example:**
```dart
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserProfileViewState extends Equatable {
  final String username;
  final String email;
  final bool isVerified;

  const UserProfileViewState({
    required this.username,
    required this.email,
    required this.isVerified,
  });

  @override
  List<Object> get props => [username, email, isVerified];

  UserProfileViewState copyWith({
    String? username,
    String? email,
    bool? isVerified,
  }) {
    return UserProfileViewState(
      username: username ?? this.username,
      email: email ?? this.email,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  factory UserProfileViewState.initial() {
    return const UserProfileViewState(
      username: '',
      email: '',
      isVerified: false,
    );
  }
}
```

**Key Points:**
- View state is UI-specific, not persisted
- Keep properties minimal - only what's needed for display
- Use `copyWith()` for immutable updates

---

## View Controller Classes

### Definition
View controllers manage view state using `Cubit` from `flutter_bloc`. They may depend on data controllers for business logic.

**Rules:**
- Extend `Cubit<ViewState>` for view state management
- Factory constructor: `fromContext(BuildContext)` reads dependencies from context
- Constructor accepts data controllers as dependencies
- Subscribe to data controller stream in constructor
- Cancel subscription in `close()`
- Implement `updateViewState()` to sync with data controller
- Generate setter methods for each view state property

**Example:**
```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view-state.dart';
import 'data-controller.dart';

class UserProfileViewController extends Cubit<UserProfileViewState> {
  final UserDataController userDataController;

  StreamSubscription<void>? dataControllerSubscription;

  factory UserProfileViewController.fromContext(BuildContext context) {
    return UserProfileViewController(context.read<UserDataController>());
  }

  UserProfileViewController(this.userDataController)
    : super(UserProfileViewState.initial()) {
    dataControllerSubscription = userDataController.stream.listen((_) {
      updateViewState();
    });
    updateViewState();
  }

  @override
  Future<void> close() async {
    await dataControllerSubscription?.cancel();
    return super.close();
  }

  void updateViewState() {
    emit(
      state.copyWith(
        username: userDataController.username,
        email: userDataController.email,
        isVerified: userDataController.isVerified,
      ),
    );
  }

  void setUsername(String username) {
    userDataController.username = username;
  }

  void setEmail(String email) {
    userDataController.email = email;
  }

  void setIsVerified(bool isVerified) {
    userDataController.isVerified = isVerified;
  }
}
```

**Key Points:**
- View controllers use `Cubit`, not `StoredCubit` (view state is not persisted)
- Data controller subscription ensures view stays in sync with data
- Setters update data controller properties, then `updateViewState()` syncs view state
- Always check `isClosed` before emitting in `updateViewState()`

---

## View Classes

### Definition
View classes are `StatelessWidget`s that display UI based on view state. They follow a 3-class pattern.

**Rules:**
- Follow 3-class pattern: `*ViewCreator`, `*View`, and optional config views
- `*ViewCreator`: BlocProvider setup with BlocBuilder
- `*View`: Stateless widget receiving controller and state
- Use `context.read<ViewController>()` to access controller
- Use `BlocBuilder` to rebuild UI on state changes

**Example:**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view-state.dart';
import 'view-controller.dart';

class UserProfileViewCreator extends StatelessWidget {
  const UserProfileViewCreator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserProfileViewController>(
      create: UserProfileViewController.fromContext,
      child: BlocBuilder<UserProfileViewController, UserProfileViewState>(
        builder: (context, state) {
          return UserProfileView(
            controller: context.read<UserProfileViewController>(),
            state: state,
          );
        },
      ),
    );
  }
}

class UserProfileView extends StatelessWidget {
  final UserProfileViewController controller;
  final UserProfileViewState state;

  const UserProfileView({
    required this.controller,
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: Column(
        children: [
          Text(state.username),
          Text(state.email),
          if (state.isVerified) const Icon(Icons.verified),
        ],
      ),
    );
  }
}
```

**Dialog Pattern:**
```dart
class UserProfileDialogView extends StatelessWidget {
  const UserProfileDialogView({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('User Profile'),
      content: const UserProfileViewCreator(),
      actions: [
        TextButton(
          onPressed: () => closeCurrentView<void>(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
```

**Key Points:**
- `*ViewCreator` wraps the view with BlocProvider and BlocBuilder
- `*View` receives controller and state as required parameters
- Use `context.read<ViewController>()` to access controller in event handlers
- For dialogs, wrap `*ViewCreator` in `AlertDialog` with close button
