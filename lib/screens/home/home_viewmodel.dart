import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  int _currentItem = 0;
  int get currentItem => _currentItem;

  set currentItem(int i) {
    _currentItem = i;
    notifyListeners();
  }
}
