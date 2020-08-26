import 'package:flutter/foundation.dart';

class TagsViewModel extends ChangeNotifier {
  List<String> tags;
  Function(List<String>) onChange;

  TagsViewModel({
    this.onChange,
    this.tags,
  })  : assert(onChange != null),
        assert(tags != null);

  void remove(String tag) {
    tags.remove(tag);
    postChange();
  }

  void add(String tag) {
    tags.add(tag);
    postChange();
  }

  // postChange is a hook that we call after the tag is changed, for processing (duplicate filtering)
  void postChange() {
    tags = tags.toSet().toList();
    notifyListeners();
    onChange(tags);
  }
}
