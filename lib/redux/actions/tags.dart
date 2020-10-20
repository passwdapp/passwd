import 'package:async_redux/async_redux.dart';
import 'package:passwd/services/password/password_service.dart';

import '../../models/tag.dart';
import '../../services/database/database_service.dart';
import '../../services/locator.dart';
import '../appstate.dart';
import 'entries.dart';

/// [AddTagAction] uses the [DatabaseService] to add a [Tag] to the database
/// Accepts a [Tag] as an input
class AddTagAction extends ReduxAction<AppState> {
  final Tag tag;
  AddTagAction(this.tag);

  @override
  void before() => dispatch(SyncIndicatorAction(isSyncing: true));

  @override
  Future<AppState> reduce() async {
    final newTag = tag
      ..id = locator<PasswordService>().generateRandomPassword(
        length: 24,
      );
    await locator<DatabaseService>().addTag(newTag);

    return null;
  }

  @override
  void after() => dispatch(ReloadAction());
}
