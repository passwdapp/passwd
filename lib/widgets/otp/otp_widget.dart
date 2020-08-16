import 'package:flutter/material.dart';
import 'package:passwd/constants/colors.dart';
import 'package:passwd/models/otp.dart';
import 'package:passwd/widgets/otp/otp_viewmodel.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:stacked/stacked.dart';

class OtpWidget extends StatelessWidget {
  final Otp otp;

  OtpWidget({@required this.otp}) : assert(otp != null);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpWidgetViewModel>.reactive(
      viewModelBuilder: () => OtpWidgetViewModel(
        otp: otp,
      ),
      builder: (context, model, child) => Container(
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
                    "Current OTP",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    model.currentOtp,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            CircularPercentIndicator(
              radius: 32,
              percent: model.percentage,
              animation: true,
              animateFromLastPercent: true,
              animationDuration: 1000,
              progressColor: primaryColor,
              backgroundColor: Colors.transparent,
              circularStrokeCap: CircularStrokeCap.round,
            ),
          ],
        ),
      ),
    );
  }
}
