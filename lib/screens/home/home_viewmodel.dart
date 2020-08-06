import 'package:flutter/foundation.dart';
import 'package:passwd/models/entry.dart';
import 'package:passwd/router/router.gr.dart';
import 'package:passwd/services/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ChangeNotifier {
  List<Entry> _entries = [];
  List<Entry> get entries => _entries;

  void toAdd() {
    locator<NavigationService>().navigateTo(Routes.addAccountScreen);
  }
}
