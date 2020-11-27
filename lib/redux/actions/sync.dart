import 'package:async_redux/async_redux.dart';

import '../../constants/api.dart';
import '../../services/cloud_sync/cloud_sync_service.dart';
import '../../services/cloud_users/cloud_users_service.dart';
import '../../services/database/database_service.dart';
import '../../services/locator.dart';
import '../../services/secure_kv/secure_kv.dart';
import '../appstate.dart';
import 'entries.dart';

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

class LoginAction extends ReduxAction<AppState> {
  final Uri uri;
  final String secret;
  final String username;
  final String password;

  LoginAction(this.uri, this.secret, this.username, this.password);

  @override
  Future<AppState> reduce() async {
    final cloudUsersService = locator<CloudUsersService>();
    await cloudUsersService.login(username, password, secret, uri);

    return state;
  }
}

class RegisterAction extends ReduxAction<AppState> {
  final Uri uri;
  final String secret;
  final String username;
  final String password;

  RegisterAction(this.uri, this.secret, this.username, this.password);

  @override
  Future<AppState> reduce() async {
    final cloudUsersService = locator<CloudUsersService>();
    await cloudUsersService.register(username, password, secret, uri);

    return state;
  }
}

class FetchEntriesAction extends ReduxAction<AppState> {
  @override
  void before() {
    dispatch(SyncIndicatorAction(isSyncing: true));
  }

  @override
  Future<AppState> reduce() async {
    final cloudSyncService = locator<CloudSyncService>();
    final syncData = await cloudSyncService.fetchRemoteEntries();

    final isNonceSame = syncData.item2;
    final isSyncSuccessful = syncData.item3;

    if (!isNonceSame && isSyncSuccessful) {
      final entries = syncData.item1;
      final dbService = locator<DatabaseService>();

      await dbService.setEntries(entries);

      return state.copyWith(
        entries: entries,
      );
    }

    return state;
  }

  @override
  void after() {
    dispatch(SyncIndicatorAction(isSyncing: false));
  }
}

class PushEntriesAction extends ReduxAction<AppState> {
  @override
  void before() {
    dispatch(SyncIndicatorAction(isSyncing: true));
  }

  @override
  Future<AppState> reduce() async {
    final cloudSyncService = locator<CloudSyncService>();
    await cloudSyncService.syncLocalEntries();

    return state;
  }

  @override
  void after() {
    dispatch(SyncIndicatorAction(isSyncing: false));
  }
}
