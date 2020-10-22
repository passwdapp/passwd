import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../models/tag.dart';
import '../../redux/actions/tags.dart';
import '../../redux/appstate.dart';

class TagsWidget extends StatefulWidget {
  final List<String> tags;
  final Function(List<String>) onChange;
  final bool showAdd;

  TagsWidget({
    @required this.onChange,
    @required this.tags,
    this.showAdd = false,
  });

  @override
  _TagsWidgetState createState() => _TagsWidgetState();
}

class _TagsWidgetState extends State<TagsWidget> {
  TextEditingController newTagController = TextEditingController();

  List<String> tags;
  List<Tag> currentTags = [];
  List<Tag> databaseTags = [];

  @override
  void initState() {
    super.initState();

    tags = widget.tags;
  }

  void loadTags() {
    final _tags = Provider.of<AppState>(
      context,
      listen: false,
    ).entries.tags;

    setState(() {
      databaseTags = _tags ?? [];

      currentTags = databaseTags
          .where(
            (element) => tags.contains(element.id),
          )
          .toList();
    });
  }

  void removeFromCurrentTags(Tag tag) {
    setState(() {
      currentTags =
          currentTags.where((element) => element.id != tag.id).toList();
      tags.remove(tag.id);
    });

    postChange();
  }

  void postChange() {
    widget.onChange(tags);
  }

  Future addTag(Tag tag) async {
    await Provider.of<DispatchFuture>(
      context,
      listen: false,
    )(AddTagAction(tag));

    loadTags();
    postChange();
  }

  void addToCurrentTags(Tag tag) {
    currentTags.add(tag);
    tags.add(tag.id);
    postChange();
  }

  @override
  Widget build(BuildContext context) {
    loadTags();
    // TODO: Localize tags before release
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tags'.toUpperCase(),
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
              ...currentTags
                  .map(
                    (tag) => widget.showAdd
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
                            backgroundColor: Colors.white.withOpacity(0.076),
                            onDeleted: () {
                              removeFromCurrentTags(tag);
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
                            backgroundColor: Colors.white.withOpacity(0.076),
                            label: Text(tag.name),
                          ),
                  )
                  .toList(),
              if (widget.showAdd)
                InputChip(
                  label: Text('+'),
                  backgroundColor: Colors.white.withOpacity(0.076),
                  onPressed: () {
                    var data = MediaQuery.of(context);
                    if (data.size.shortestSide > 600) {
                      showCheckDialog();
                    } else {
                      showCheckSheet();
                    }
                  },
                )
            ],
          )
        ],
      ),
    );
  }

  void showCheckSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => getCheckSheet(),
    );
  }

  void showCheckDialog() {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: SizedBox(
          width: 380,
          child: getCheckSheet(true),
        ),
      ),
    );
  }

  Widget getCheckSheet([
    bool preferDialog = false,
  ]) {
    Widget sheet = Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...databaseTags.map(
            (tag) {
              var isChecked = currentTags.indexWhere(
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
                      addToCurrentTags(tag);
                    } else {
                      removeFromCurrentTags(tag);
                    }
                  },
                ),
              );
            },
          ).toList(),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add a tag'),
            onTap: () {
              Navigator.of(context).pop();

              if (preferDialog) {
                showAddDialog((t) async {
                  await addTag(t);
                  showCheckDialog();
                });
              } else {
                showAddSheet((t) async {
                  await addTag(t);
                  showCheckSheet();
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
                'Done'.toUpperCase(),
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

  void showAddSheet(Future Function(Tag) callback) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => getAddSheet(callback),
    );
  }

  void showAddDialog(Future Function(Tag) callback) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: SizedBox(
          width: 380,
          child: getAddSheet(callback),
        ),
      ),
    );
  }

  Widget getAddSheet(Future Function(Tag) callback) {
    var currentColor = 0;

    return Material(
      child: StatefulBuilder(
        builder: (context, setSheetState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Wrap(
            children: [
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name'.toUpperCase(),
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
                            setSheetState(() => currentColor = index);
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
                        newTagController.clear();
                      },
                      child: Text(
                        'Cancel'.toUpperCase(),
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
                        'Save'.toUpperCase(),
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

  @override
  void dispose() {
    newTagController.dispose();
    super.dispose();
  }
}
