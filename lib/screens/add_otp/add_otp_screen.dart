import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:supercharged/supercharged.dart';

import '../../models/otp.dart';
import '../../utils/capitalization_formatter.dart';
import '../../utils/validate.dart';
import '../../validators/otp_secret_validator.dart';

class AddOtpScreen extends StatefulWidget {
  @override
  _AddOtpScreenState createState() => _AddOtpScreenState();
}

class _AddOtpScreenState extends State<AddOtpScreen> {
  String secret = "";
  int digits = 6;
  int period = 30;

  bool isSecretValid = false;
  bool isDigitsValid = true;
  bool isPeriodValid = true;

  TextEditingController secretController = TextEditingController();
  TextEditingController digitsController = TextEditingController(text: "6");
  TextEditingController periodController = TextEditingController(text: "30");

  FocusNode digitsFocus = FocusNode();
  FocusNode periodFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    initializeTextEditingControllers();
  }

  void initializeTextEditingControllers() {
    secretController.addListener(() {
      setState(() {
        secret = secretController.text;

        isSecretValid = validate<bool>(
            OtpSecretValidator(), secret.toUpperCase(), true, false);
      });
    });

    digitsController.addListener(() {
      setState(() {
        digits =
            digitsController.text.isEmpty ? 0 : digitsController.text.toInt();

        if (digits >= 6 && digits <= 8 && digits != null) {
          isDigitsValid = true;
        } else {
          isDigitsValid = false;
        }
      });
    });

    periodController.addListener(() {
      setState(() {
        period = periodController.text.toInt();

        if (period == 30 || period == 60) {
          isPeriodValid = true;
        } else {
          isPeriodValid = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.getString("enter_manually"),
          style: TextStyle(
            letterSpacing: 1.25,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          tooltip: context.getString("back_tooltip"),
          icon: Icon(Feather.x_circle),
        ),
        actions: [
          IconButton(
            onPressed: isSecretValid && isDigitsValid && isPeriodValid
                ? () {
                    Otp otp = Otp(
                      account: "ih", // ih stands for inherit (from parent)
                      algorithm: "SHA1",
                      digits: digits,
                      issuer: "ih",
                      secret: secret,
                      timeout: period,
                      type: "t", // T is TOTP
                    );

                    Navigator.of(context).pop(otp);
                  }
                : null,
            tooltip: context.getString("done_tooltip"),
            icon: Icon(Feather.check_circle),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: const BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          children: [
            TextFormField(
              controller: secretController,
              decoration: InputDecoration(
                labelText: context.getString("otp_secret").toUpperCase(),
                errorText: isSecretValid
                    ? null
                    : context.getString("otp_secret_invalid"),
              ),
              inputFormatters: [
                CapitalizationFormatter(),
              ],
              textCapitalization: TextCapitalization.characters,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (val) {
                digitsFocus.requestFocus();
              },
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: digitsController,
              decoration: InputDecoration(
                labelText: context.getString("digits").toUpperCase(),
                errorText:
                    isDigitsValid ? null : context.getString("digits_invalid"),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              focusNode: digitsFocus,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (val) {
                periodFocus.requestFocus();
              },
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: periodController,
              decoration: InputDecoration(
                labelText: context.getString("otp_period").toUpperCase(),
                errorText: isPeriodValid
                    ? null
                    : context.getString("otp_period_invalid"),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              focusNode: periodFocus,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      ),
    );
  }
}
