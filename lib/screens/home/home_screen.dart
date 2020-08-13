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
          leading: IconButton(
            icon: Icon(Feather.settings),
            onPressed: () {},
            tooltip: "Settings",
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
              tooltip: "Add an account",
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
                          "No accounts here",
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
                              "Use the ",
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
                              " icon to add one",
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
                              title:
                                  Text("Do you want to delete this account?"),
                              actions: [
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No"),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    model.removeEntry(i);
                                  },
                                  child: Text("Yes"),
                                ),
                              ],
                            ),
                          );
                        },
                        onTap: () {
                          print("Hello world");
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
                        Text("Syncing"),
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
