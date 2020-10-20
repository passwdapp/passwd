import 'dart:async';

import 'package:dart_otp/dart_otp.dart';
import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../constants/colors.dart';
import '../../models/otp.dart';

class OtpWidget extends StatefulWidget {
  final Otp otp;

  OtpWidget({@required this.otp}) : assert(otp != null);

  @override
  _OtpWidgetState createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  double percentage = 0.0;
  String currentOtp = "";

  TOTP totp;
  Timer timer;

  @override
  void initState() {
    super.initState();

    totp = TOTP(
      secret: widget.otp.secret,
      algorithm: OTPAlgorithm.SHA1,
      digits: widget.otp.digits,
      interval: widget.otp.timeout,
    );
    timer = Timer.periodic(
      const Duration(
        milliseconds: 100,
      ),
      (_) {
        genOtp();
      },
    );
    genOtp();
  }

  void genOtp() {
    setState(() {
      currentOtp = totp.now();
      percentage =
          (widget.otp.timeout - (DateTime.now().second % widget.otp.timeout)) /
              widget.otp.timeout;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.getString("current_otp").toUpperCase(),
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
                  currentOtp,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          CircularPercentIndicator(
            radius: 28,
            lineWidth: 4,
            percent: percentage,
            animation: true,
            animateFromLastPercent: true,
            animationDuration: 1000,
            progressColor: primaryColor,
            backgroundColor: Colors.transparent,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
