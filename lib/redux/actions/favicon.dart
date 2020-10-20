import 'package:async_redux/async_redux.dart';
import 'package:passwd/redux/actions/entries.dart';

import '../../models/entry.dart';
import '../../services/favicon/favicon_service.dart';
import '../../services/locator.dart';
import '../../utils/validate.dart';
import '../../validators/url_validator.dart';
import '../appstate.dart';

/// [AddFaviconAction] uses the [FaviconService] to retrieve a favicon, and dispatches a [ModifyEntryAction] to add the favicon to the entry
/// This is usually dispatched after [AddEntryAction]
/// It accepts an [Entry] as the argument
class AddFaviconAction extends ReduxAction<AppState> {
  final Entry entry;
  AddFaviconAction(this.entry);

  @override
  Future<AppState> reduce() async {
    if (entry.name != null &&
        validate<bool>(URLValidator(), entry.name, true, false)) {
      String favicon = await locator<FaviconService>().getBestFavicon(
        entry.name.startsWith("http")
            ? Uri.parse(entry.name).host
            : entry.name.split("/")[0],
      );

      if (favicon.isNotEmpty) {
        Entry newEntry = entry..favicon = favicon;

        await dispatchFuture(ModifyEntryAction(entry, newEntry));
      }
    }
    return null;
  }
}
