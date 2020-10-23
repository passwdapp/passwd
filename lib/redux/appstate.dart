import 'package:functional_data/functional_data.dart';

import '../models/entries.dart';

part 'appstate.g.dart';

/// [AppState] holds the whole app's state in a single object
/// Redux is a immutable state solution, and requires your state to object (single source of truth)
/// Everytime the application's state needs to be changed, a new copy of the state is made. The original object is never mutated
/// Views (Widgets) dispatch actions, which create a new copy of the state and update the views
/// Redux is known to be robust and unit testable
/// As dart doesn't natively support data classes, [AppState] uses [FunctionData] and codegen to generate the copyWith method and the == operator
@FunctionalData()
class AppState extends $AppState {
  @override
  final Entries entries;

  @override
  final bool isSyncing;

  @override
  final bool autofillLaunch;

  AppState({
    this.entries,
    this.isSyncing,
    this.autofillLaunch,
  });
}
