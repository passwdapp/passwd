import 'package:tuple/tuple.dart';

import '../../models/entries.dart';

abstract class CloudSyncService {
  Future<Tuple4<Entries, bool, bool, bool>> fetchRemoteEntries([
    Tuple3<Uri, String, String> storedData,
  ]);

  Future<bool> syncLocalEntries();
}
