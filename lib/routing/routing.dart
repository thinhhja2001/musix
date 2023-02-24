import 'package:flutter/material.dart';

import '../domain_artist/views/screens.dart';
import '../domain_global/views/screens.dart';
import '../domain_playlist/views/screens.dart';
import '../domain_user/views/screens.dart';
import 'routing_path.dart';

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
    case RoutingPath.profile:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ProfileScreen(),
      );
    case RoutingPath.home:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const HomeScreen(),
      );
    case RoutingPath.playlistList:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const PlaylistListScreen(),
      );
    case RoutingPath.playlistInfo:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const PlaylistInfoScreen(),
      );
    case RoutingPath.artistInfo:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ArtistInfoScreen(),
      );
    case RoutingPath.changePassword:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ChangePasswordScreen(),
      );
    case RoutingPath.editProfile:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const EditProfileScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const Scaffold(),
      );
  }
}
