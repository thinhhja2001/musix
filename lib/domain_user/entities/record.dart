import 'package:equatable/equatable.dart';

import '../../domain_song/entities/entities.dart';

class UserRecord extends Equatable {
  final List<String>? searchRecord;
  final String? searchHistory;
  final String? searchSong;
  final Map<String, SongInfo>? songRecord;

  const UserRecord({
    this.searchRecord,
    this.songRecord,
    this.searchSong,
    this.searchHistory,
  });

  UserRecord copyWith({
    List<String>? searchRecord,
    Map<String, SongInfo>? songRecord,
    String? searchHistory,
    String? searchSong,
  }) {
    return UserRecord(
      searchRecord: searchRecord ?? this.searchRecord,
      songRecord: songRecord ?? this.songRecord,
      searchHistory: searchHistory ?? this.searchHistory,
      searchSong: searchSong ?? this.searchSong,
    );
  }

  @override
  List<Object?> get props =>
      [searchRecord, songRecord, searchHistory, searchSong];

  @override
  String toString() {
    return '(${searchRecord?.length} search, ${songRecord?.length} songs, $searchHistory, $searchSong)`';
  }
}
