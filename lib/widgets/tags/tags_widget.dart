import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';

import '../../constants/colors.dart';
import '../../models/device_type.dart';
import '../../models/tag.dart';
import '../../utils/get_device_type.dart';
import 'tags_viewmodel.dart';

class TagsWidget extends HookWidget {
  final List<String> tags;
  final Function(List<String>) onChange;
  final bool showAdd;

  TagsWidget({
    @required this.onChange,
    @required this.tags,
    this.showAdd = false,
  })  : assert(onChange != null),
        assert(tags != null);

  @override
  Widget build(BuildContext context) {
    // TODO: Localize tags before release
    return ViewModelBuilder<TagsViewModel>.reactive(
      viewModelBuilder: () => TagsViewModel(
        tags: tags,
        onChange: onChange,
      ),
      builder: (context, model, child) => Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tags".toUpperCase(),
              style: TextStyle(
                fontSize: 13,
                letterSpacing: 1.5,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Wrap(
              spacing: 8,
              runSpacing: -8,
              children: [
                ...model.currentTags
                    .map(
                      (tag) => showAdd
                          ? InputChip(
                              avatar: Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  color: tagColors[tag.color].color,
                                ),
                              ),
                              label: Text(tag.name),
                              deleteIcon: Icon(
                                Icons.clear,
                                size: 16,
                              ),
                              onDeleted: () {
                                model.removeFromCurrentTags(tag);
                              },
                            )
                          : Chip(
                              avatar: Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  color: tagColors[tag.color].color,
                                ),
                              ),
                              label: Text(tag.name),
                            ),
                    )
                    .toList(),
                if (showAdd)
                  InputChip(
                    label: Text("+"),
                    onPressed: () {
                      MediaQueryData data = MediaQuery.of(context);
                      if (getDeviceType(data) == DeviceType.DESKTOP) {
                        showCheckDialog(context, model);
                      } else {
                        showCheckSheet(context, model);
                      }
                    },
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  void showCheckSheet(BuildContext context, TagsViewModel model) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => getCheckSheet(context, model),
    );
  }

  void showCheckDialog(BuildContext context, TagsViewModel model) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: SizedBox(
          width: 380,
          child: getCheckSheet(context, model, true),
        ),
      ),
    );
  }

  Widget getCheckSheet(
    BuildContext context,
    TagsViewModel model, [
    bool preferDialog = false,
  ]) {
    Widget sheet = Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...model.databaseTags.map(
            (tag) {
              bool isChecked = model.currentTags.indexWhere(
                    (element) => element.id == tag.id,
                  ) !=
                  -1;

              return StatefulBuilder(
                builder: (context, setState) => CheckboxListTile(
                  value: isChecked,
                  checkColor: Colors.black,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: tagColors[tag.color].color,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(tag.name),
                    ],
                  ),
                  onChanged: (val) {
                    setState(() => isChecked = val);

                    if (val) {
                      model.addToCurrentTags(tag);
                    } else {
                      model.removeFromCurrentTags(tag);
                    }
                  },
                ),
              );
            },
          ).toList(),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Add a tag"),
            onTap: () {
              Navigator.of(context).pop();

              if (preferDialog) {
                showAddDialog(context, (t) async {
                  await model.addTag(t);
                  showCheckDialog(context, model);
                });
              } else {
                showAddSheet(context, (t) async {
                  await model.addTag(t);
                  showCheckSheet(context, model);
                });
              }
            },
          ),
          ListTile(
            title: FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Done".toUpperCase(),
              ),
            ),
          ),
        ],
      ),
    );

    if (preferDialog) {
      return Material(
        child: sheet,
      );
    } else {
      return sheet;
    }
  }

  void showAddSheet(BuildContext context, Future Function(Tag) callback) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => getAddSheet(context, callback),
    );
  }

  void showAddDialog(BuildContext context, Future Function(Tag) callback) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: SizedBox(
          width: 380,
          child: getAddSheet(context, callback),
        ),
      ),
    );
  }

  Widget getAddSheet(BuildContext context, Future Function(Tag) callback) {
    TextEditingController newTagController = TextEditingController();

    int currentColor = 0;

    return Material(
      child: StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Wrap(
            children: [
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Name".toUpperCase(),
                  ),
                  controller: newTagController,
                ),
              ),
              ListTile(
                title: SizedBox(
                  width: double.infinity,
                  height: 32,
                  child: ListView.builder(
                    itemCount: tagColors.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(
                        right: 8,
                      ),
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: tagColors[index].color,
                          border: Border.all(
                            color: currentColor == index
                                ? Colors.white
                                : Colors.transparent,
                            width: 4,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() => currentColor = index);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel".toUpperCase(),
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        Navigator.of(context).pop();

                        if (newTagController.text.isNotEmpty) {
                          await callback(
                            Tag(
                              color: currentColor,
                              name: newTagController.text,
                            ),
                          );
                          newTagController.clear();
                        }
                      },
                      child: Text(
                        "Save".toUpperCase(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
