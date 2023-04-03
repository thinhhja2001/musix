class RoutingPath {
  // Authentication
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String emailVerification = "/emailVerification";
  static const String requestForgetOtp = '/requestForgetOtp';
  static const String resetPassword = '/resetPassword';

  // Main
  static const String home = '/home_music';

  // User
  static const String profile = '$home/profile';
  static const String changePassword = '$profile/changePassword';
  static const String editProfile = '$profile/edit';

  // Search
  static const String searchSong = '$home/searchSong';
  static const String searchVideo = '$home/searchVideo';

  // Album - Topic - Playlist
  static const String hubInfo = '$home/hubInfo';
  static const String playlistInfo = '$home/playlistInfo';
  static const String playlistsInfo = '$home/playlistsInfo';

  // Artist
  static const String artistInfo = '$home/artistInfo';
  static const String artistsInfo = '$home/artistsInfo';

  // Video
  static const String video = "/video";
  static const String videoDetailPage = "$video/detail";

  // Social
  static const String social = "/social";
  static const String viewComment = "$social/commentView";
}
