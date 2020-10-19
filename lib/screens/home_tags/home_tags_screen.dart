import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stacked/stacked.dart';

import '../../constants/colors.dart';
import '../../widgets/home_list_item.dart';
import 'home_tags_viewmodel.dart';

// Navigation Item, not to be navigated to
// So not injected in auto_route
class HomeTagsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeTagsViewModel>.reactive(
      viewModelBuilder: () => HomeTagsViewModel(),
      builder: (context, model, child) => model.entries.entries.length != 0
          ? ListView.builder(
              itemCount: model.tags.length,
              itemBuilder: (context, i) => ExpansionTile(
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Feather.chevron_down),
                ),
                title: Row(
                  children: [
                    Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: tagColors[model.tags[i].color].color,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(model.tags[i].name),
                  ],
                ),
                children: model.entries.entries
                    .where((entry) {
                      return entry.tags.indexOf(model.tags[i].id) != -1;
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
            ),
    );
  }
}

// TODO: localize no_tags
