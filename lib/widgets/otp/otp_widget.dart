import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
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
                    context.getString("current_otp").toUpperCase(),
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 1.5,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.5),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    model.currentOtp,
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
              percent: model.percentage,
              animation: true,
              animateFromLastPercent: true,
              animationDuration: 1000,
              progressColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.transparent,
              circularStrokeCap: CircularStrokeCap.round,
            ),
          ],
        ),
      ),
    );
  }
}
