import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:passwd/constants/colors.dart';

class PinInputWidget extends StatelessWidget {
  final void Function(String) onSubmit;

  PinInputWidget({@required this.onSubmit}) : assert(onSubmit != null);

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      filled: true,
      obscureText: false,
      fillColor: Colors.white.withOpacity(0.18),
      borderColor: Colors.transparent,
      cursorColor: primaryColor,
      showFieldAsBox: true,
      autoFocus: true,
      numberOfFields: 4,
      onCodeChanged: (String value) {},
      onSubmit: onSubmit,
      hasCustomInputDecoration: false,
      textStyle: Theme.of(context).textTheme.headline6,
      enabledBorderColor: Colors.transparent,
      focusedBorderColor: Colors.transparent,
      fieldWidth: 64,
    );
  }
}
