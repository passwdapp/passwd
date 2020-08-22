import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:passwd/screens/generate_password/generate_password_viewmodel.dart';
import 'package:passwd/utils/is_dark.dart';
import 'package:passwd/widgets/button.dart';
import 'package:stacked/stacked.dart';
import 'package:supercharged/supercharged.dart';

class GeneratePasswordScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController wordController = useTextEditingController.fromValue(
      TextEditingValue(text: "5"),
    );

    return ViewModelBuilder<GeneratePasswordViewModel>.reactive(
      viewModelBuilder: () => GeneratePasswordViewModel(),
      onModelReady: (model) {
        model.getPassword(
          length: model.words,
          capitalize: model.capitalize,
        );

        wordController.addListener(() {
          model.words = wordController.text.toInt();
        });
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            context.getString("password"),
            style: TextStyle(
              letterSpacing: 1.25,
              fontSize: 18,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              model.pop();
            },
            tooltip: context.getString("back_tooltip"),
            icon: Icon(Feather.x_circle),
          ),
          actions: [
            IconButton(
              onPressed: () {
                model.popWithPassword(model.password);
              },
              tooltip: context.getString("done_tooltip"),
              icon: Icon(Feather.check_circle),
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
              height: 8,
            ),
            Text(
              model.password,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 0,
              ),
              value: model.diceware,
              onChanged: (val) {
                model.diceware = val;
                if (val) {
                  model.words = 5;
                  wordController.text = "5";
                } else {
                  model.words = 16;
                  wordController.text = "16";
                }
                model.getPassword(
                  length: model.words,
                  capitalize: model.capitalize,
                );
              },
              title: Text(
                context.getString("memorizable"),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            TextFormField(
              controller: wordController,
              decoration: InputDecoration(
                labelText: model.diceware
                    ? context.getString("no_words").toUpperCase()
                    : context.getString("length").toUpperCase(),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              onFieldSubmitted: (val) {
                model.getPassword(
                  length: model.words,
                  capitalize: model.capitalize,
                );
              },
            ),
            SizedBox(
              height: 12,
            ),
            model.diceware
                ? Column(
                    children: [
                      SwitchListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0,
                        ),
                        value: model.capitalize,
                        onChanged: (val) {
                          model.capitalize = val;
                          model.getPassword(
                            length: model.words,
                            capitalize: model.capitalize,
                          );
                        },
                        title: Text(
                          context.getString("capitalize"),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  )
                : Container(),
            Button(
              child: Text(
                context.getString("regenrate_password"),
                style: TextStyle(
                  color: isDark(context) ? Theme.of(context).canvasColor : null,
                ),
              ),
              onClick: () {
                model.getPassword(
                  length: model.words,
                  capitalize: model.capitalize,
                );
              },
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
