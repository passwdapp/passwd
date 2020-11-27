import 'dart:io';
import 'dart:ui';

import 'package:async_redux/async_redux.dart';
import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:touch_bar/touch_bar.dart';

import '../../constants/colors.dart';
import '../../models/entry.dart';
import '../../redux/actions/entries.dart';
import '../../redux/actions/sync.dart';
import '../../redux/appstate.dart';
import '../../utils/navigation_utils.dart';
import '../../widgets/home_list_item.dart';
import '../../widgets/title.dart';
import '../account_details/account_details_screen.dart';
import '../add_account/add_account_screen.dart';
import '../search/search_screen.dart';
import '../settings/settings_screen.dart';

// Navigation Item, not to be navigated to
// So not injected in auto_route
class HomePasswordsScreen extends StatefulWidget {
  @override
  _HomePasswordsScreenState createState() => _HomePasswordsScreenState();
}

class _HomePasswordsScreenState extends State<HomePasswordsScreen> {
  List<String> selectedTags = [];

  Future addAccount() async {
    Entry entry = await navigate(context, AddAccountScreen());

    if (entry != null) {
      await Provider.of<DispatchFuture>(
        context,
        listen: false,
      )(AddEntryAction(entry));
    }
  }

  Future initTouchBar(List<Entry> entries) async {
    if (entries.isNotEmpty && Platform.isMacOS) {
      await setTouchBar(
        TouchBar(
          children: [
            TouchBarButton(
              label: 'Add an account', // TODO: localize this
              onClick: () {
                addAccount();
              },
            ),
            TouchBarScrubber(
              mode: ScrubberMode.free,
              isContinuous: false,
              onSelect: (i) async {
                await navigate(
                  context,
                  AccountDetailsScreen(
                    entry: entries[i],
                  ),
                );

                return await initTouchBar(entries);
              },
              children: entries
                  .map(
                    (e) => TouchBarScrubberLabel(
                      e.name,
                      textColor: Colors.white,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);

    var filteredEntries = selectedTags.isEmpty
        ? state.entries.entries
        : state.entries.entries
            .where(
              (e) => e.tags.fold(
                false,
                (value, tag) => value || selectedTags.contains(tag),
              ),
            )
            .toList();

    initTouchBar(filteredEntries);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 18,
              sigmaY: 18,
            ),
            child: Container(
              color: canvasColor.withOpacity(0.8),
              padding: const EdgeInsets.only(
                top: 16,
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: state.autofillLaunch
            ? null
            : Builder(
                builder: (context) => IconButton(
                  icon: Icon(Feather.settings),
                  onPressed: () {
                    navigate(
                      context,
                      SettingsScreen(),
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
            icon: Icon(Feather.search),
            onPressed: () async {
              await navigate(
                context,
                SearchScreen(autofillLaunch: state.autofillLaunch),
              );
            },
            tooltip: 'Search', // TODO: localize search
          ),
        ],
        bottom: (state.entries.tags != null && state.entries.tags.isNotEmpty)
            ? PreferredSize(
                preferredSize: const Size.fromHeight(40.0),
                child: Container(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: SizedBox(
                    height: 36,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.entries.tags != null
                          ? state.entries.tags.length
                          : 0,
                      itemBuilder: (context, i) {
                        var isSelected =
                            selectedTags.contains(state.entries.tags[i].id);

                        return Container(
                          padding: const EdgeInsets.only(
                            right: 8,
                          ),
                          child: ChoiceChip(
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: isSelected
                                    ? primaryColor
                                    : Colors.transparent,
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: primaryColor.withOpacity(0.084),
                            onSelected: (e) {
                              setState(() {
                                if (e) {
                                  selectedTags.add(state.entries.tags[i].id);
                                } else {
                                  selectedTags.remove(state.entries.tags[i].id);
                                }
                              });
                            },
                            avatar: Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: tagColors[state.entries.tags[i].color]
                                    .color,
                              ),
                            ),
                            label: Text(
                              state.entries.tags[i].name,
                              style: TextStyle(
                                color: Colors.grey[200],
                              ),
                            ),
                            backgroundColor: Colors.white.withOpacity(0.076),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            : null,
      ),
      floatingActionButton: state.autofillLaunch
          ? null
          : FloatingActionButton(
              onPressed: () async {
                await addAccount();
              },
              tooltip: context.getString('add_account'),
              child: Icon(Feather.plus),
            ),
      body: filteredEntries.isEmpty
          ? noEntriesLayout
          : RefreshIndicator(
              onRefresh: () async {
                await Provider.of<DispatchFuture>(context, listen: false)(
                    PushEntriesAction());
              },
              child: ListView.builder(
                padding: EdgeInsets.only(
                  bottom: 16,
                  top: MediaQuery.of(context).padding.top +
                      kToolbarHeight +
                      ((state.entries.tags != null &&
                              state.entries.tags.isNotEmpty)
                          ? 40
                          : 0),
                ),
                itemBuilder: (context, i) => HomeListItem(
                  entry: filteredEntries[i],
                  autofillLaunch: state.autofillLaunch,
                  onReturnFromDetails: () {
                    initTouchBar(filteredEntries);
                  },
                ),
                itemCount: filteredEntries.length,
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
              ),
            ),
    );
  }

  Widget get noEntriesLayout => Column(
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
                style: Theme.of(context).textTheme.bodyText1.copyWith(
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
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.white.withOpacity(0.6),
                    ),
              ),
            ],
          ),
        ],
      );

  // Not used as of now
  Widget get syncingIndicator => SizedBox(
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
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
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
      );
}
