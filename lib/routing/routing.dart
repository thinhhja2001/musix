import 'package:flutter/material.dart';
import 'package:musix/domain_user/views/screens.dart';
import 'package:musix/routing/routing_path.dart';

Map<String, WidgetBuilder> mapRoutingMusixApp = {
  RoutingPath.signIn: (BuildContext context) => const SignInScreen(),
  RoutingPath.signUp: (BuildContext context) => const SignUpScreen(),
  RoutingPath.forgetPassword: (BuildContext context) =>
      const ForgetPasswordScreen(),
};

Route<dynamic> routeController(RouteSettings settings) {
  final routingPath = settings.name;

  switch (routingPath) {
    case RoutingPath.signIn:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const SignInScreen(),
      );
    case RoutingPath.signUp:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const SignUpScreen(),
      );
    case RoutingPath.forgetPassword:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ForgetPasswordScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const Scaffold(),
      );
  }
}
