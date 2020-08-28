import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:passwd/models/tag.dart';
import 'package:passwd/services/database/database_service.dart';
import 'package:passwd/services/locator.dart';
import 'package:passwd/services/password/password_service.dart';

class TagsViewModel extends ChangeNotifier {
  // Tags coming from the widget
  List<String> tags;
  // onChange hook fired back to the parent
  Function(List<String>) onChange;

  TagsViewModel({
    this.onChange,
    this.tags,
  }) {
    assert(onChange != null);
    assert(tags != null);

    loadTags();
  }

  List<Tag> databaseTags;
  // Stores the current tags' ID
  List<Tag> currentTags = [];

  void loadTags() {
    List<Tag> _tags = locator<DatabaseService>().entries.tags;
    databaseTags = _tags ?? [];
    print(json.encode(databaseTags));

    currentTags = databaseTags
        .where(
          (element) => tags.contains(element.id),
        )
        .toList();

    notifyListeners();
  }

  @deprecated
  void remove(String id) {
    tags.remove(id);
    currentTags = currentTags.where((element) => element.id != id).toList();
    postChange();
  }

  void addToCurrentTags(Tag tag) {
    currentTags.add(tag);
    tags.add(tag.id);
    postChange();
  }

  void removeFromCurrentTags(Tag tag) {
    currentTags = currentTags.where((element) => element.id != tag.id).toList();
    tags.remove(tag.id);

    postChange();
  }

  Future addTag(Tag tag) async {
    tag.id = locator<PasswordService>().generateRandomPassword(
      length: 24,
    );

    await locator<DatabaseService>().addTag(tag);

    loadTags();
    postChange();
  }

  // postChange is a hook that we call after the tag is changed, for processing (duplicate filtering)
  void postChange() {
    notifyListeners();
    onChange(tags);
  }
}
