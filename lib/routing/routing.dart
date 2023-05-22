import 'package:flutter/material.dart';
import 'package:musix/domain_social/views/screen.dart';
import 'package:musix/domain_user/entities/entities.dart';

import '../domain_artist/views/screens.dart';
import '../domain_auth/views/screens/email_verification_screen/email_verification_screen.dart';
import '../domain_auth/views/screens/reset_password_screen/reset_password_screen.dart';
import '../domain_auth/views/screens/sign_in_screen/sign_in_screen.dart';
import '../domain_auth/views/screens/sign_up_screen/sign_up_screen.dart';
import '../domain_global/views/screens.dart';
import '../domain_hub/views/screens.dart';
import '../domain_playlist/views/screens.dart';
import '../domain_social/entities/post/post.dart';
import '../domain_song/views/screens.dart';
import '../domain_user/views/screens.dart';
import '../domain_video/views/screens/video_detail_page_widget.dart';
import 'routing_path.dart';

Route<dynamic> routeController(RouteSettings settings) {
  final routingPath = settings.name;

  switch (routingPath) {
    case RoutingPath.signIn:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => SignInScreen(),
      );
    case RoutingPath.signUp:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const SignUpScreen(),
      );
    case RoutingPath.emailVerification:
      return MaterialPageRoute(
          settings: settings,
          builder: (context) => const EmailVerificationScreen());
    case RoutingPath.requestForgetOtp:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => RequestForgetOTPScreen(),
      );
    case RoutingPath.resetPassword:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => ResetPasswordScreen(),
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
    case RoutingPath.playlistsInfo:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const PlaylistsInfoScreen(),
      );
    case RoutingPath.artistInfo:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ArtistInfoScreen(),
      );
    case RoutingPath.artistsInfo:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ArtistsInfoScreen(),
      );
    case RoutingPath.songsInfo:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const SongsInfoScreen(),
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
    case RoutingPath.ownPlaylists:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const OwnPlaylistsScreen(),
      );
    case RoutingPath.ownPlaylist:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const OwnPlaylistScreen(),
      );
    case RoutingPath.searchRecord:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const SearchRecordScreen(),
      );
    case RoutingPath.songRecord:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const SongRecordScreen(),
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
    case RoutingPath.searchSocial:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const SearchSocialScreen(),
      );
    case RoutingPath.viewComment:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ViewCommentScreen(),
      );
    case RoutingPath.createNewPost:
      return MaterialPageRoute(
          settings: settings, builder: (context) => CreateNewPostScreen());
    case RoutingPath.modifyPost:
      final post = settings.arguments as Post;
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => ModifyPostScreen(post: post),
      );
    case RoutingPath.profileSocial:
      final user = settings.arguments as User;
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => ProfileSocialScreen(user: user),
      );
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const Scaffold(),
      );
  }
}
