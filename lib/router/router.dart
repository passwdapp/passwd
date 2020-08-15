import 'package:auto_route/auto_route_annotations.dart';
import 'package:passwd/screens/account_details/account_details_screen.dart';
import 'package:passwd/screens/add_account/add_account_screen.dart';
import 'package:passwd/screens/add_otp/add_otp_screen.dart';
import 'package:passwd/screens/generate_password/generate_password_screen.dart';
import 'package:passwd/screens/get_started/get_started_screen.dart';
import 'package:passwd/screens/home/home_screen.dart';
import 'package:passwd/screens/init/init_screen.dart';
import 'package:passwd/screens/set_pin/set_pin_screen.dart';
import 'package:passwd/screens/verify_pin/verify_pin_screen.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(
      page: InitScreen,
      initial: true,
    ),
    MaterialRoute(
      page: GetStartedScreen,
    ),
    MaterialRoute(
      page: SetPinScreen,
    ),
    MaterialRoute(
      page: VerifyPinScreen,
    ),
    MaterialRoute(
      page: HomeScreen,
    ),
    MaterialRoute(
      page: AddAccountScreen,
    ),
    MaterialRoute(
      page: GeneratePasswordScreen,
    ),
    MaterialRoute(
      page: AccountDetailsScreen,
    ),
    MaterialRoute(
      page: AddOtpScreen,
    ),
  ],
)
class $Router {}
