import 'package:async_redux/async_redux.dart';
import 'package:autofill_service/autofill_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../models/entry.dart';
import '../redux/actions/entries.dart';
import '../screens/account_details/account_details_screen.dart';
import '../utils/get_first_letter.dart';
import '../utils/loggers.dart';
import '../utils/navigation_utils.dart';

class HomeListItem extends StatefulWidget {
  final Entry entry;
  final double size;
  final VoidCallback onReturnFromDetails;
  final bool autofillLaunch;

  HomeListItem({
    @required this.entry,
    this.size = 40,
    @required this.onReturnFromDetails,
    @required this.autofillLaunch,
  }) : assert(entry != null);

  @override
  _HomeListItemState createState() => _HomeListItemState();
}

class _HomeListItemState extends State<HomeListItem> {
  Future showPopupMenu(Offset globalPosition) async {
    final entry = widget.entry;

    var size = MediaQuery.of(context).size;
    final selected = await showMenu(
      color: Color(0xff242424),
      context: context,
      position: RelativeRect.fromLTRB(
        globalPosition.dx,
        globalPosition.dy,
        size.width - globalPosition.dx,
        size.height - globalPosition.dy,
      ),
      items: [
        PopupMenuItem(
          child: Text(
            'Delete ${entry.name ?? entry.username}',
          ), // TODO: localize
          value: 0,
        ),
        PopupMenuItem(
          child: Text(
            'Copy Password for ${entry.name ?? entry.username}',
          ), // TODO: localize
          value: 1,
        ),
      ],
    );

    switch (selected) {
      case 0:
        showDeleteDialog();
        break;

      case 1:
        copy(entry.password);
        break;
    }
  }

  void showOptionsSheet() {
    final entry = widget.entry;

    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            title: Text(
              'Delete ${entry.name ?? entry.username}',
            ), // TODO: localize
            onTap: () {
              Navigator.of(context).pop();
              showDeleteDialog();
            },
          ),
          ListTile(
            title: Text(
              'Copy Password for ${entry.name ?? entry.username}',
            ), // TODO: localize
            onTap: () {
              Navigator.of(context).pop();
              copy(entry.password);
            },
          ),
        ],
      ),
    );
  }

  void copy(String text) {
    Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          context.getString('copied_to_clipboard'),
        ),
      ),
    );
  }

  void showDeleteDialog() {
    final entry = widget.entry;

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
              )(RemoveEntryAction(entry));
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

  Future handleItemClick(Entry entry, bool autofill) async {
    if (!autofill) {
      await navigate(
        context,
        AccountDetailsScreen(
          entry: entry,
        ),
      );
    } else {
      final response = await AutofillService().resultWithDataset(
        label: entry.name ?? entry.username,
        username: entry.username,
        password: entry.password,
      );

      Loggers.mainLogger.info('autofill $response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapDown: widget.autofillLaunch
          ? null
          : (details) {
              showPopupMenu(details.globalPosition);
            },
      child: InkWell(
        onLongPress: widget.autofillLaunch
            ? null
            : () {
                showOptionsSheet();
              },
        onTap: () async {
          await handleItemClick(widget.entry, widget.autofillLaunch);
          widget.onReturnFromDetails();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Container(
            width: double.infinity,
            height: widget.size,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: widget.entry.favicon.isNotEmpty
                      ? Container(
                          color: Colors.white,
                          child: CachedNetworkImage(
                            imageUrl: widget.entry.favicon,
                            width: widget.size,
                            height: widget.size,
                            placeholder: (context, url) =>
                                getContainer(widget.entry, context),
                            errorWidget: (context, url, error) =>
                                getContainer(widget.entry, context),
                          ),
                        )
                      : getContainer(widget.entry, context),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.entry.name.isEmpty
                            ? widget.entry.username
                            : widget.entry.name,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              fontSize: 16,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      widget.entry.name.isNotEmpty
                          ? Text(
                              widget.entry.username,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.76),
                                fontSize: 13,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getContainer(Entry entry, BuildContext context) {
    return Container(
      width: widget.size,
      color: iconColors[entry.colorId],
      child: Center(
        child: Text(
          getFirstLetter(entry),
          style: Theme.of(context).textTheme.headline4.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
        ),
      ),
    );
  }
}
