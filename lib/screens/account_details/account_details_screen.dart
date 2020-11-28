import 'dart:io';

import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:passwd/screens/add_account/add_account_screen.dart';
import 'package:touch_bar/touch_bar.dart';

import '../../models/entry.dart';
import '../../widgets/otp/otp_widget.dart';
import '../../widgets/tags/tags_widget.dart';

class AccountDetailsScreen extends StatefulWidget {
  final Entry entry;

  AccountDetailsScreen({@required this.entry}) : assert(entry != null);

  @override
  _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();

    initTouchBar();
  }

  void copyPassword() {
    Clipboard.setData(
      ClipboardData(
        text: widget.entry.password,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          context.getString('copied_to_clipboard'),
        ),
      ),
    );
  }

  Future initTouchBar() async {
    if (Platform.isMacOS) {
      await setTouchBar(
        TouchBar(
          children: [
            TouchBarLabel(
              widget.entry.username,
              textColor: Colors.white,
            ),
            TouchBarSpace.small(),
            TouchBarButton(
              label: 'Copy Password', // TODO: localize this
              onClick: () {
                copyPassword();
              },
            ),
            if (widget.entry.name != null) TouchBarSpace.flexible(),
            if (widget.entry.name != null)
              TouchBarLabel(
                widget.entry.name,
                textColor: Colors.white,
              ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.entry.name.isNotEmpty
              ? widget.entry.name
              : widget.entry.username,
          style: TextStyle(
            letterSpacing: 1.25,
            fontSize: 18,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          tooltip: context.getString('back_tooltip'),
          icon: Icon(Feather.x_circle),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AddAccountScreen(entry: widget.entry),
              ));
            },
            tooltip: context.getString('edit_tooltip'),
            icon: Icon(Feather.edit),
          ),
        ],
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        children: [
          SizedBox(
            height: 4,
          ),
          if (widget.entry.name.isNotEmpty)
            getRow(
                context.getString('name_url').toUpperCase(), widget.entry.name),
          getRow(context.getString('username_email').toUpperCase(),
              widget.entry.username),
          getRow(
            context.getString('password').toUpperCase(),
            isPasswordVisible ? widget.entry.password : '•••••••••••••••',
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
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  child: Text(
                    isPasswordVisible
                        ? context.getString('hide_password')
                        : context.getString('show_password'),
                  ),
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) => FlatButton(
                    onPressed: () {
                      copyPassword();
                    },
                    child: Text(
                      context.getString('copy_password'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          if (widget.entry.note.isNotEmpty)
            getRow(context.getString('notes').toUpperCase(), widget.entry.note),
          if (widget.entry.otp != null) OtpWidget(otp: widget.entry.otp),
          if (widget.entry.tags.isNotEmpty)
            SizedBox(
              height: 16,
            ),
          if (widget.entry.tags.isNotEmpty)
            TagsWidget(
              onChange: (_) {},
              tags: widget.entry.tags,
              showAdd: false,
            ),
          SizedBox(
            height: 16,
          ),
        ],
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
