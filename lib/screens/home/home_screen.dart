import 'package:flutter/material.dart';
import 'package:passwd/screens/home/home_viewmodel.dart';
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
            icon: Icon(Icons.settings_outlined),
            onPressed: () {},
            tooltip: "Settings",
          ),
          centerTitle: true,
          title: TitleWidget(
            textSize: 20,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                model.toAdd();
              },
              tooltip: "Add an account",
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Center(
            child: Column(
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
                      " icon to add one",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.white.withOpacity(0.6),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
