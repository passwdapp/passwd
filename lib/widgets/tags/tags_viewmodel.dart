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

  void postChange() {
    tags = tags.toSet().toList();
    notifyListeners();
    onChange(tags);
  }
}
