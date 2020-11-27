import 'package:async_redux/async_redux.dart';

import '../../constants/api.dart';
import '../../services/locator.dart';
import '../../services/secure_kv/secure_kv.dart';
import '../appstate.dart';

class CheckLoginAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    final kvService = locator<SecureKVService>();
    final accessToken = await kvService.getValue(ACCESS_TOKEN_KEY);

    return state.copyWith(
      isLoggedIn: accessToken != null && accessToken != '',
    );
  }
}
