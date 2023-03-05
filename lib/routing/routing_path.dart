class RoutingPath {
  // Authentication
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String forgetPassword = '/forgetPassword';

  // Main
  static const String home = '/home_music';

  // User
  static const String profile = '$home/profile';
  static const String changePassword = '$profile/changePassword';
  static const String editProfile = '$profile/edit';

  // Search
  static const String search = '$home/search';

  // Album - Topic - Playlist
  static const String hubInfo = '$home/hubInfo';
  static const String playlistInfo = '$home/playlistInfo';

  // Artist
  static const String artistInfo = '$home/artistInfo';

  // Video
  static const String video = "/video";
  static const String videoDetailPage = "$video/detail";
}
