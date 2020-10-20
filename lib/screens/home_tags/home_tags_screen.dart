import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../redux/appstate.dart';
import '../../widgets/home_list_item.dart';

// Navigation Item, not to be navigated to
// So not injected in auto_route
class HomeTagsScreen extends StatefulWidget {
  @override
  _HomeTagsScreenState createState() => _HomeTagsScreenState();
}

class _HomeTagsScreenState extends State<HomeTagsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);

    return state.entries.entries.length != 0
        ? ListView.builder(
            itemCount: state.entries.tags.length,
            itemBuilder: (context, i) => ExpansionTile(
              title: Row(
                children: [
                  Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: tagColors[state.entries.tags[i].color].color,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(state.entries.tags[i].name),
                ],
              ),
              children: state.entries.entries
                  .where((entry) {
                    return entry.tags.indexOf(state.entries.tags[i].id) != -1;
                  })
                  .map(
                    (e) => HomeListItem(entry: e),
                  )
                  .toList(),
            ),
          )
        : Center(
            child: Text(
              "no_tags",
              style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.white.withOpacity(0.6),
                  ),
            ),
          );
  }
}

// TODO: localize no_tags
