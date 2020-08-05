import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:passwd/screens/add_account/add_account_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AddAccountScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = useTextEditingController();
    TextEditingController usernameController = useTextEditingController();
    TextEditingController passwordController = useTextEditingController();
    TextEditingController urlController = useTextEditingController();
    TextEditingController notesController = useTextEditingController();

    FocusNode usernameFocus = useFocusNode();
    FocusNode passwordFocus = useFocusNode();
    FocusNode urlFocus = useFocusNode();
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

        urlController.addListener(() {
          model.url = urlController.text;
        });

        notesController.addListener(() {
          model.notes = notesController.text;
        });
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("Add an account"),
        ),
        body: SafeArea(
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            children: [
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Account Name",
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {
                  usernameFocus.requestFocus();
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(),
                ),
                focusNode: usernameFocus,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {
                  passwordFocus.requestFocus();
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
                focusNode: passwordFocus,
                obscureText: true,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {
                  urlFocus.requestFocus();
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: urlController,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  hintText: "URL",
                  border: OutlineInputBorder(),
                ),
                focusNode: urlFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {
                  notesFocus.requestFocus();
                },
              ),
              SizedBox(
                height: 16,
              ),
              RaisedButton(
                onPressed: () {},
                child: Text(
                  "Two Factor Authentication",
                  style: TextStyle(
                    color: Theme.of(context).canvasColor,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: notesController,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Additional Notes",
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.done,
                focusNode: notesFocus,
              ),
              SizedBox(
                height: 48,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text("Done"),
          icon: Icon(Icons.check),
        ),
      ),
    );
  }
}
