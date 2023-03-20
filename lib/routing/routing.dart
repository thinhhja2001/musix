import 'package:flutter/material.dart';
import 'package:musix/domain_social/views/screens/view_comment_screen.dart';

import '../domain_artist/views/screens.dart';
import '../domain_global/views/screens.dart';
import '../domain_hub/views/screens.dart';
import '../domain_playlist/views/screens.dart';
import '../domain_user/views/screens.dart';
import '../domain_video/views/screens/video_detail_page_widget.dart';
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
        builder: (context) => const SlashHomeScreen(),
        // builder: (context) => const HomeScreen(),
      );
    case RoutingPath.hubInfo:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const HubInfoScreen(),
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
    case RoutingPath.videoDetailPage:
      return MaterialPageRoute(
          settings: settings,
          builder: (context) => const VideoDetailPageWidget());
    case RoutingPath.searchSong:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) =>
            const SearchScreen(searchScreenType: SearchScreenType.song),
        // builder: (context) => const HomeScreen(),
      );
    case RoutingPath.searchVideo:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) =>
            const SearchScreen(searchScreenType: SearchScreenType.video),
        // builder: (context) => const HomeScreen(),
      );
    case RoutingPath.viewComment:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ViewCommentScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const Scaffold(),
      );
  }
}
