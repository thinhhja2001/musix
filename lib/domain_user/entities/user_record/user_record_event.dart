import 'package:musix/domain_song/entities/entities.dart';

abstract class UserRecordEvent {
  const UserRecordEvent();
}

class GetUserRecordEvent implements UserRecordEvent {
  const GetUserRecordEvent();
}

class SaveUserSearchRecordEvent implements UserRecordEvent {
  final String search;
  const SaveUserSearchRecordEvent(this.search);
}

class DeleteUserSearchRecordEvent implements UserRecordEvent {
  final String? search;
  final bool isDeleteAll;
  const DeleteUserSearchRecordEvent({this.search, this.isDeleteAll = false});
}

class SaveUserSongRecordEvent implements UserRecordEvent {
  final SongInfo songInfo;
  const SaveUserSongRecordEvent(this.songInfo);
}

class DeleteUserSongRecordEvent implements UserRecordEvent {
  final SongInfo? search;
  final bool isDeleteAll;
  const DeleteUserSongRecordEvent({this.search, this.isDeleteAll = false});
}

class SearchHistoryEvent implements UserRecordEvent {
  final String search;
  const SearchHistoryEvent(this.search);
}

class SearchRecentSongEvent implements UserRecordEvent {
  final String search;
  const SearchRecentSongEvent(this.search);
}

class RecommendPlaylistEvent implements UserRecordEvent {
  final String token;
  const RecommendPlaylistEvent(this.token);
}

class UserRecordResetEvent implements UserRecordEvent {}
