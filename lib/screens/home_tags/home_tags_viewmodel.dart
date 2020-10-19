import 'package:flutter/foundation.dart';
import 'package:passwd/models/entries.dart';

import '../../models/tag.dart';
import '../../services/database/database_service.dart';
import '../../services/locator.dart';

class HomeTagsViewModel extends ChangeNotifier {
  List<Tag> _tags = [];
  List<Tag> get tags => _tags;

  Entries _entries = Entries(entries: []);
  Entries get entries => _entries;

  HomeTagsViewModel() {
    reloadTags(true);
  }

  Future reloadTags([bool reload = false]) async {
    if (reload) {
      await locator<DatabaseService>().reloadDatabaseFromDisk();
    }

    final entries = locator<DatabaseService>().entries;
    _entries = entries;
    _tags = entries.tags;

    notifyListeners();
  }
}
