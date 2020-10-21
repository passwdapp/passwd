import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:supercharged/supercharged.dart';

import '../../services/locator.dart';
import '../../services/password/password_service.dart';
import '../../widgets/button.dart';

class GeneratePasswordScreen extends StatefulWidget {
  @override
  _GeneratePasswordScreenState createState() => _GeneratePasswordScreenState();
}

class _GeneratePasswordScreenState extends State<GeneratePasswordScreen> {
  TextEditingController wordController = TextEditingController.fromValue(
    TextEditingValue(text: '5'),
  );

  String password = '';
  int words = 5;
  bool capitalize = true;
  bool diceware = true;

  Future getPassword({
    int length = 5,
    bool capitalize = true,
  }) async {
    if (diceware) {
      final generatedPassword =
          await locator<PasswordService>().generateDicewarePassword(
        words: length,
        capitalize: capitalize,
      );
      setState(() {
        password = generatedPassword;
      });
    } else {
      final generatedPassword =
          locator<PasswordService>().generateRandomPassword(
        length: length,
      );
      setState(() {
        password = generatedPassword;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    wordController.addListener(() {
      setState(() {
        words = wordController.text.toInt();
      });
    });

    getPassword(
      length: words,
      capitalize: capitalize,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.getString('password'),
          style: TextStyle(
            letterSpacing: 1.25,
            fontSize: 18,
          ),
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
              Navigator.of(context).pop(password);
            },
            tooltip: context.getString('done_tooltip'),
            icon: Icon(Feather.check_circle),
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
            height: 8,
          ),
          Text(
            password,
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
            value: diceware,
            onChanged: (val) {
              setState(() {
                diceware = val;

                if (val) {
                  words = 5;
                  wordController.text = '5';
                } else {
                  words = 16;
                  wordController.text = '16';
                }
              });

              getPassword(
                length: words,
                capitalize: capitalize,
              );
            },
            title: Text(
              context.getString('memorizable'),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          TextFormField(
            controller: wordController,
            decoration: InputDecoration(
              labelText: diceware
                  ? context.getString('no_words').toUpperCase()
                  : context.getString('length').toUpperCase(),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            onFieldSubmitted: (val) {
              getPassword(
                length: words,
                capitalize: capitalize,
              );
            },
          ),
          SizedBox(
            height: 12,
          ),
          if (diceware)
            Column(
              children: [
                SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  value: capitalize,
                  onChanged: (val) {
                    setState(() {
                      capitalize = val;
                    });

                    getPassword(
                      length: words,
                      capitalize: capitalize,
                    );
                  },
                  title: Text(
                    context.getString('capitalize'),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
          Button(
            child: Text(
              context.getString('regenrate_password'),
            ),
            onClick: () {
              getPassword(
                length: words,
                capitalize: capitalize,
              );
            },
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    wordController.dispose();
    super.dispose();
  }
}
