import 'package:flutter/material.dart';
import 'package:musix/domain_global/views/screens.dart';
import 'package:musix/domain_user/views/screens.dart';
import 'package:musix/routing/routing_path.dart';

import '../domain_album/models/models.dart';
import '../domain_album/views/screens.dart';
import '../domain_artist/views/screens.dart';

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
    case RoutingPath.topicSelection:
      final topic = settings.arguments as Topic;
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => TopicSelectionScreen(
          topic: topic,
        ),
      );
    case RoutingPath.albumInfo:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const AlbumInfoScreen(),
      );
    case RoutingPath.artistInfo:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ArtistInfoScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const Scaffold(),
      );
  }
}
