import 'package:functional_data/functional_data.dart';

import '../models/entries.dart';

part 'appstate.g.dart';

@FunctionalData()
class AppState extends $AppState {
  final Entries entries;
  final bool isSyncing;

  AppState({
    this.entries,
    this.isSyncing,
  });
}
