import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:passwd/models/entry.dart';
import 'package:passwd/screens/account_details/account_details_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AccountDetailsScreen extends StatelessWidget {
  final Entry entry;

  AccountDetailsScreen({@required this.entry}) : assert(entry != null);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountDetailsViewModel>.reactive(
      viewModelBuilder: () => AccountDetailsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            entry.name.isNotEmpty ? entry.name : entry.username,
            style: TextStyle(
              letterSpacing: 1.25,
              fontSize: 18,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          leading: IconButton(
            onPressed: () {
              model.pop();
            },
            tooltip: "Back",
            icon: Icon(Feather.x_circle),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // model.pop();
              },
              tooltip: "Edit",
              icon: Icon(Feather.edit),
            ),
          ],
        ),
        body: ListView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: const BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          children: [
            if (entry.name.isNotEmpty) Text("Hello"),
          ],
        ),
      ),
    );
  }
}
