import 'package:equatable/equatable.dart';

import '../../domain_song/entities/entities.dart';

class UserRecord extends Equatable {
  final List<String>? searchRecord;
  final Map<String, SongInfo>? songRecord;

  const UserRecord({
    this.searchRecord,
    this.songRecord,
  });

  UserRecord copyWith({
    List<String>? searchRecord,
    Map<String, SongInfo>? songRecord,
  }) {
    return UserRecord(
      searchRecord: searchRecord ?? this.searchRecord,
      songRecord: songRecord ?? this.songRecord,
    );
  }

  @override
  List<Object?> get props => [searchRecord, songRecord];

  @override
  String toString() {
    return '${searchRecord?.length} search, ${songRecord?.length} songs`';
  }
}
