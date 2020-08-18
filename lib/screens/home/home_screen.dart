import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:passwd/constants/colors.dart';
import 'package:passwd/screens/home/home_viewmodel.dart';
import 'package:passwd/widgets/home_list_item.dart';
import 'package:passwd/widgets/title.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Feather.settings),
              onPressed: () {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      context.getString("under_construction"),
                    ),
                  ),
                );
              },
              tooltip: context.getString("settings_tooltip"),
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
                await model.toAdd();
              },
              tooltip: context.getString("add_account"),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: model.entries.entries.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          context.getString("no_accounts"),
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
                              context.getString("use_the"),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                            ),
                            Icon(
                              Icons.add,
                              color: Colors.white.withOpacity(0.6),
                              size: 20,
                            ),
                            Text(
                              context.getString("icon_to_add"),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemBuilder: (context, i) => InkWell(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                context.getString("deletion_dialog_title"),
                              ),
                              content: RichText(
                                text: TextSpan(
                                  text: context.getString("warning"),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[200],
                                  ),
                                  children: [
                                    TextSpan(
                                      text: context.getString("irreversible"),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    model.removeEntry(i);
                                  },
                                  child: Text(
                                    context.getString("yes"),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    context.getString("no"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        onTap: () {
                          model.showDetails(model.entries.entries[i]);
                        },
                        child: HomeListItem(
                          entry: model.entries.entries[i],
                        ),
                      ),
                      itemCount: model.entries.entries.length,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: const BouncingScrollPhysics(),
                      ),
                    ),
            ),
            model.loading
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
                          context.getString("syncing"),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
