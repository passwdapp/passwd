import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:passwd/widgets/tags/tags_viewmodel.dart';
import 'package:stacked/stacked.dart';

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
    TextEditingController newTagController = useTextEditingController();

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
                ...model.tags
                    .map(
                      (tag) => InputChip(
                        label: Text(tag),
                        deleteIcon: Icon(
                          Icons.clear,
                          size: 16,
                        ),
                        onDeleted: () {
                          model.remove(tag);
                        },
                      ),
                    )
                    .toList(),
                if (showAdd)
                  InputChip(
                    label: Text("+"),
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => Container(
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
                                      onPressed: () {
                                        Navigator.of(context).pop();

                                        if (newTagController.text.isNotEmpty) {
                                          model.add(newTagController.text);
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
                      );
                    },
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
