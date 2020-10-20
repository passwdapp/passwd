import 'package:async_redux/async_redux.dart';
import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:passwd/screens/account_details/account_details_screen.dart';
import 'package:passwd/utils/navigation_utils.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../models/entry.dart';
import '../../redux/actions/entries.dart';
import '../../redux/appstate.dart';
import '../../widgets/home_list_item.dart';
import '../../widgets/title.dart';
import '../add_account/add_account_screen.dart';

// Navigation Item, not to be navigated to
// So not injected in auto_route
class HomePasswordsScreen extends StatefulWidget {
  @override
  _HomePasswordsScreenState createState() => _HomePasswordsScreenState();
}

class _HomePasswordsScreenState extends State<HomePasswordsScreen> {
  double x = 0;
  double y = 0;

  Future showPopupMenu(int index, Entry entry) async {
    var size = MediaQuery.of(context).size;
    final selected = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        x,
        y,
        size.width - x,
        size.height - y,
      ),
      items: [
        PopupMenuItem(
          child: Text('Delete ${entry.name}'),
          value: 0,
        ),
        PopupMenuItem(
          child: Text('Copy Password for ${entry.name}'),
          value: 1,
        ),
      ],
    );

    switch (selected) {
      case 0:
        showDeleteDialog(index);
        break;

      case 1:
        copy(entry.password);
        break;
    }
  }

  void copy(String text) {
    Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          context.getString('copied_to_clipboard'),
        ),
      ),
    );
  }

  void showDeleteDialog(int i) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          context.getString('deletion_dialog_title'),
        ),
        content: RichText(
          text: TextSpan(
            text: context.getString('warning'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red[200],
            ),
            children: [
              TextSpan(
                text: context.getString('irreversible'),
              ),
            ],
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () async {
              Navigator.of(context).pop();

              await Provider.of<DispatchFuture>(
                context,
                listen: false,
              )(RemoveEntryAction(i));
            },
            child: Text(
              context.getString('yes'),
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              context.getString('no'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Feather.settings),
            onPressed: () {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    context.getString('under_construction'),
                  ),
                ),
              );
            },
            tooltip: context.getString('settings_tooltip'),
          ),
        ),
        centerTitle: true,
        title: TitleWidget(
          textSize: 24,
        ),
        actions: [
          IconButton(
            icon: Icon(Feather.plus_circle),
            onPressed: () async {
              Entry entry = await navigate(context, AddAccountScreen());

              if (entry != null) {
                await Provider.of<DispatchFuture>(
                  context,
                  listen: false,
                )(AddEntryAction(entry));
              }
            },
            tooltip: context.getString('add_account'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: state.entries.entries.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        context.getString('no_accounts'),
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.white.withOpacity(0.6),
                            ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            context.getString('use_the'),
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                          ),
                          Icon(
                            Icons.add,
                            color: Colors.white.withOpacity(0.6),
                            size: 20,
                          ),
                          Text(
                            context.getString('icon_to_add'),
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                          ),
                        ],
                      ),
                    ],
                  )
                : MouseRegion(
                    onHover: (event) {
                      x = event.position.dx;
                      y = event.position.dy;
                    },
                    child: ListView.builder(
                      itemBuilder: (context, i) => GestureDetector(
                        onSecondaryTap: () {
                          showPopupMenu(i, state.entries.entries[i]);
                        },
                        child: InkWell(
                          onLongPress: () {
                            showPopupMenu(i, state.entries.entries[i]);
                          },
                          onTap: () {
                            navigate(
                              context,
                              AccountDetailsScreen(
                                  entry: state.entries.entries[i]),
                            );
                          },
                          child: HomeListItem(
                            entry: state.entries.entries[i],
                          ),
                        ),
                      ),
                      itemCount: state.entries.entries.length,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                    ),
                  ),
          ),
          state.isSyncing
              ? SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(primaryColor),
                          strokeWidth: 3.0,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        context.getString('syncing'),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
