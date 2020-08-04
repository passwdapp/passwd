import 'package:auto_route/auto_route_annotations.dart';
import 'package:passwd/screens/get_started/get_started_screen.dart';
import 'package:passwd/screens/set_pin/set_pin_screen.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(
      page: GetStartedScreen,
      initial: true,
    ),
    MaterialRoute(
      page: SetPinScreen,
    ),
  ],
)
class $Router {}
