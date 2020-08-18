import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:passwd/screens/add_otp/add_otp_viewmodel.dart';
import 'package:passwd/utils/capitalization_formatter.dart';
import 'package:stacked/stacked.dart';
import 'package:supercharged/supercharged.dart';

class AddOtpScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController secretController = useTextEditingController();
    TextEditingController digitsController = useTextEditingController(
      text: "6",
    );
    TextEditingController periodController = useTextEditingController(
      text: "30",
    );

    FocusNode digitsFocus = useFocusNode();
    FocusNode periodFocus = useFocusNode();

    return ViewModelBuilder<AddOtpViewModel>.reactive(
      viewModelBuilder: () => AddOtpViewModel(),
      onModelReady: (model) {
        secretController.addListener(() {
          model.secret = secretController.text;
        });

        digitsController.addListener(() {
          model.digits =
              digitsController.text.isEmpty ? 0 : digitsController.text.toInt();
        });

        periodController.addListener(() {
          model.period = periodController.text.toInt();
        });
      },
      builder: (context, model, child) => Scaffold(
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
              model.pop();
            },
            tooltip: context.getString("back_tooltip"),
            icon: Icon(Feather.x_circle),
          ),
          actions: [
            IconButton(
              onPressed: model.isSecretValid &&
                      model.isDigitsValid &&
                      model.isPeriodValid
                  ? () {
                      model.popWithData();
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
                  errorText: model.isSecretValid
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
                  errorText: model.isDigitsValid
                      ? null
                      : context.getString("digits_invalid"),
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
                  errorText: model.isPeriodValid
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
      ),
    );
  }
}
