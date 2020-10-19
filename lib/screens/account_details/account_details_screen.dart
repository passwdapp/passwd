import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stacked/stacked.dart';

import '../../models/entry.dart';
import '../../widgets/otp/otp_widget.dart';
import '../../widgets/tags/tags_widget.dart';
import 'account_details_viewmodel.dart';

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
            tooltip: context.getString("back_tooltip"),
            icon: Icon(Feather.x_circle),
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        context.getString("under_construction"),
                      ),
                    ),
                  );
                },
                tooltip: context.getString("edit_tooltip"),
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
              getRow(context.getString("name_url").toUpperCase(), entry.name),
            getRow(context.getString("username_email").toUpperCase(),
                entry.username),
            getRow(
              context.getString("password").toUpperCase(),
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
                      model.passwordVisible
                          ? context.getString("hide_password")
                          : context.getString("show_password"),
                    ),
                  ),
                ),
                Expanded(
                  child: Builder(
                    builder: (context) => FlatButton(
                      onPressed: () {
                        model.copy(entry.password);
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              context.getString("copied_to_clipboard"),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        context.getString("copy_password"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            if (entry.note.isNotEmpty)
              getRow(context.getString("notes").toUpperCase(), entry.note),
            if (entry.otp != null) OtpWidget(otp: entry.otp),
            if (entry.tags.length != 0)
              SizedBox(
                height: 16,
              ),
            if (entry.tags.length != 0)
              TagsWidget(
                onChange: (_) {},
                tags: entry.tags,
                showAdd: false,
              ),
            SizedBox(
              height: 16,
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
