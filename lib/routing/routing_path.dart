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

  // Album - Topic - Playlist
  static const String playlistList = '$home/playlists';
  static const String playlistInfo = '$home/playlist';

  // Artist
  static const String artistInfo = '$home/artistInfo';
}
