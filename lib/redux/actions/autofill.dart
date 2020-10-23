import 'package:async_redux/async_redux.dart';

import '../appstate.dart';

class AutoFillLaunchTypeAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.copyWith(
      autofillLaunch: true,
    );
  }
}
