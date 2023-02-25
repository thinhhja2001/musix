import 'package:flutter/material.dart';
import 'package:musix/domain_video/views/screens/video_detail_page_widget.dart';

import '../domain_album/views/screens.dart';
import '../domain_artist/views/screens.dart';
import '../domain_global/views/screens.dart';
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
    case RoutingPath.topicSelection:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const TopicSelectionScreen(),
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
    case RoutingPath.videoDetailPage:
      return MaterialPageRoute(
          settings: settings,
          builder: (context) => const VideoDetailPageWidget());
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const Scaffold(),
      );
  }
}
