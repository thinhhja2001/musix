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
  final SongInfo search;
  const SaveUserSongRecordEvent(this.search);
}

class DeleteUserSongRecordEvent implements UserRecordEvent {
  final SongInfo? search;
  final bool isDeleteAll;
  const DeleteUserSongRecordEvent({this.search, this.isDeleteAll = false});
}
