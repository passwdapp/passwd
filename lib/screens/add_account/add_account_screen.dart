import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:passwd/screens/add_account/add_account_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AddAccountScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = useTextEditingController();
    TextEditingController usernameController = useTextEditingController();
    TextEditingController passwordController = useTextEditingController();
    TextEditingController notesController = useTextEditingController();

    FocusNode usernameFocus = useFocusNode();
    FocusNode passwordFocus = useFocusNode();
    FocusNode notesFocus = useFocusNode();

    return ViewModelBuilder<AddAccountViewModel>.reactive(
      viewModelBuilder: () => AddAccountViewModel(),
      onModelReady: (model) {
        nameController.addListener(() {
          model.name = nameController.text;
        });

        usernameController.addListener(() {
          model.username = usernameController.text;
        });

        passwordController.addListener(() {
          model.password = passwordController.text;
        });

        notesController.addListener(() {
          model.notes = notesController.text;
        });
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add an Account",
            style: TextStyle(
              letterSpacing: 1.25,
              fontSize: 18,
            ),
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
              onPressed: () {},
              tooltip: "Done",
              icon: Icon(Feather.check_circle),
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "URL".toUpperCase(),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {
                  usernameFocus.requestFocus();
                },
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Email/Username".toUpperCase(),
                ),
                focusNode: usernameFocus,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {
                  passwordFocus.requestFocus();
                },
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password".toUpperCase(),
                ),
                focusNode: passwordFocus,
                obscureText: true,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {
                  notesFocus.requestFocus();
                },
              ),
              SizedBox(
                height: 12,
              ),
              RaisedButton(
                onPressed: () {
                  model.generatePassword((pass) {
                    passwordController.text = pass;
                  });
                },
                child: Text("Generate a Password"),
                color: Colors.white.withOpacity(0.14),
                visualDensity: VisualDensity(
                  horizontal: 4,
                  vertical: 2,
                ),
              ),
              TextFormField(
                controller: notesController,
                decoration: InputDecoration(
                  labelText: "Notes".toUpperCase(),
                ),
                textInputAction: TextInputAction.done,
                focusNode: notesFocus,
                onFieldSubmitted: (val) {
                  notesFocus.unfocus();
                },
              ),
              SizedBox(
                height: 12,
              ),
              RaisedButton(
                onPressed: () {},
                child: Text("Two factor authentication"),
                color: Colors.white.withOpacity(0.14),
                visualDensity: VisualDensity(
                  horizontal: 4,
                  vertical: 2,
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
