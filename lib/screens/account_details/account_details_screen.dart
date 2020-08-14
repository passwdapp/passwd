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
            Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Henlo world, I am still under construction",
                      ),
                    ),
                  );
                },
                tooltip: "Edit",
                icon: Icon(Feather.edit),
              ),
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
            SizedBox(
              height: 4,
            ),
            if (entry.name.isNotEmpty)
              getRow("Name/URL".toUpperCase(), entry.name),
            getRow("Username/Email".toUpperCase(), entry.username),
            getRow(
              "Password".toUpperCase(),
              model.passwordVisible ? entry.password : "•••••••••••••••",
              false,
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      model.passwordVisible = !model.passwordVisible;
                    },
                    child: Text(
                      model.passwordVisible ? "Hide Password" : "Show Password",
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      model.copy(entry.password);
                    },
                    child: Text(
                      "Copy Password",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            if (entry.note.isNotEmpty)
              getRow("Notes".toUpperCase(), entry.note),
            SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget getRow(String label, String content, [bool padding = true]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            letterSpacing: 1.5,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        if (padding)
          SizedBox(
            height: 24,
          ),
      ],
    );
  }
}
