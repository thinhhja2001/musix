import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/exporter.dart';
import '../../domain_song/entities/entities.dart';
import '../../domain_song/utils/utils.dart';
import '../../utils/utils.dart';
import '../entities/entities.dart';

class UserRecordBloc extends Bloc<UserRecordEvent, UserRecordState> {
  UserRecordBloc({
    required UserRecordState initialState,
    required this.authBloc,
    required this.userMusicRepo,
    required this.songRepo,
    required this.recommendRepo,
  }) : super(initialState) {
    authBloc.stream.listen((authState) {
      if (authState.username != null &&
          authState.jwtToken != null &&
          authState.jwtToken != "") {
        token = authState.jwtToken!;
      }
    });
    on<GetUserRecordEvent>(_getUserRecord);
    on<SaveUserSearchRecordEvent>(_saveUserSearchRecord);
    on<DeleteUserSearchRecordEvent>(_deleteUserSearchRecord);
    on<SaveUserSongRecordEvent>(_saveUserSongRecord);
    on<DeleteUserSongRecordEvent>(_deleteUserSongRecord);
    on<SearchHistoryEvent>(_searchHistory);
    on<SearchRecentSongEvent>(_searchRecentSong);
    on<RecommendPlaylistEvent>(_recommendPlaylist);
    on<UserRecordResetEvent>(_userRecordResetEvent);
  }

  final AuthBloc authBloc;
  final UserMusicRepo userMusicRepo;
  final SongInfoRepositoryImpl songRepo;
  final SongRecommendationRepo recommendRepo;
  String token = "";

  //----------------------------------------------------------------------------
  @override
  void onError(Object error, StackTrace stackTrace) {
    DebugLogger debugLogger = DebugLogger();
    debugLogger.log('$error\n $stackTrace');
    super.onError(error, stackTrace);
  }

  FutureOr<void> _saveUserSearchRecord(
      SaveUserSearchRecordEvent event, Emitter<UserRecordState> emit) async {
    var userRecord = state.record;
    var searchRecord = userRecord?.searchRecord;
    if (searchRecord != null && searchRecord.contains(event.search)) {
      return;
    }
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserRecordStatusKey.search.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );

      await userMusicRepo.saveSearchRecord(token: token, search: event.search);
      searchRecord?.add(event.search);
      userRecord = userRecord?.copyWith(
        searchRecord: searchRecord,
      );

      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserRecordStatusKey.search.name,
          ], status: [
            Status.success,
          ]),
          record: () => userRecord,
        ),
      );
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserRecordStatusKey.search.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(
          Exception(
              "UserRecordBloc _saveUserSearchRecord error ${e.toString()}"),
          StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        UserRecordStatusKey.search.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _deleteUserSearchRecord(
      DeleteUserSearchRecordEvent event, Emitter<UserRecordState> emit) async {
    var userRecord = state.record;
    var searchRecord = userRecord?.searchRecord;
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserRecordStatusKey.search.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );

      bool result = await userMusicRepo.deleteSearchRecord(
          token: token, search: event.search, isDeleteAll: event.isDeleteAll);
      debugPrint('$result - ${event.isDeleteAll}');
      if (result) {
        if (event.isDeleteAll) {
          searchRecord = [];
        } else {
          searchRecord?.remove(event.search);
        }
      }

      userRecord = userRecord?.copyWith(
        searchRecord: searchRecord,
      );

      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserRecordStatusKey.search.name,
          ], status: [
            Status.success,
          ]),
          record: () => userRecord,
        ),
      );
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserRecordStatusKey.search.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(
          Exception(
              "UserRecordBloc _deleteUserSearchRecord error ${e.toString()}"),
          StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        UserRecordStatusKey.search.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _searchHistory(
      SearchHistoryEvent event, Emitter<UserRecordState> emit) async {
    if (event.search == state.record?.searchHistory) {
      return;
    }
    var userRecord = state.record;
    userRecord = userRecord?.copyWith(searchHistory: event.search);
    emit(
      state.copyWith(record: () => userRecord),
    );
  }

  FutureOr<void> _saveUserSongRecord(
      SaveUserSongRecordEvent event, Emitter<UserRecordState> emit) async {
    var userRecord = state.record;

    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserRecordStatusKey.song.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      await userMusicRepo.saveSongRecord(
          token: token, songId: event.songInfo.encodeId!);
      var songRecord = userRecord?.songRecord;
      songRecord?[event.songInfo.encodeId!] = event.songInfo;
      userRecord = userRecord?.copyWith(
        songRecord: songRecord,
      );

      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserRecordStatusKey.song.name,
          ], status: [
            Status.success,
          ]),
          record: () => userRecord,
        ),
      );
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserRecordStatusKey.song.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(
          Exception("UserRecordBloc _saveUserSongRecord error ${e.toString()}"),
          StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        UserRecordStatusKey.song.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _deleteUserSongRecord(
      DeleteUserSongRecordEvent event, Emitter<UserRecordState> emit) async {
    var userRecord = state.record;
    var songRecord = userRecord?.songRecord;
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserRecordStatusKey.song.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );

      var result = await userMusicRepo.deleteSongRecord(
          token: token,
          search: event.search?.encodeId,
          isDeleteAll: event.isDeleteAll);

      if (result) {
        if (event.isDeleteAll) {
          songRecord = {};
        } else {
          songRecord?.remove(event.search?.encodeId);
        }
      }

      userRecord = userRecord?.copyWith(
        songRecord: songRecord,
      );

      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserRecordStatusKey.song.name,
          ], status: [
            Status.success,
          ]),
          record: () => userRecord,
        ),
      );
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserRecordStatusKey.song.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(
          Exception(
              "UserRecordBloc _deleteUserSongRecord error ${e.toString()}"),
          StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        UserRecordStatusKey.song.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _searchRecentSong(
      SearchRecentSongEvent event, Emitter<UserRecordState> emit) async {
    if (event.search == state.record?.searchSong) {
      return;
    }
    var userRecord = state.record;
    userRecord = userRecord?.copyWith(searchSong: event.search);
    emit(
      state.copyWith(record: () => userRecord),
    );
  }

  FutureOr<void> _getUserRecord(
      GetUserRecordEvent event, Emitter<UserRecordState> emit) async {
    try {
      print("get user record called");
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserRecordStatusKey.global.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var userRecordModel = await userMusicRepo.getUserRecord(token: token);
      var songIds = userRecordModel.record?.songRecord;
      var searchRecord = userRecordModel.record?.searchRecord;
      Map<String, SongInfo> songs = {};
      if (songIds != null) {
        for (String id in songIds) {
          final response = await songRepo.getInfo(id);
          final song = convertSongInfoModel(response);
          songs[id] = song!;
        }
      }

      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserRecordStatusKey.global.name,
          ], status: [
            Status.success,
          ]),
          record: () =>
              UserRecord(searchRecord: searchRecord, songRecord: songs),
        ),
      );
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserRecordStatusKey.global.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(Exception("UserRecordBloc _getUserRecord error ${e.toString()}"),
          StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        UserRecordStatusKey.global.name,
      ], status: [
        Status.idle,
      ]),
    ));

    add(RecommendPlaylistEvent(token));
  }

  FutureOr<void> _recommendPlaylist(
      RecommendPlaylistEvent event, Emitter<UserRecordState> emit) async {
    var songs = await UserMusicRepo().getTop10MostListenedSong(token: token);
    if (songs.isEmpty) return;
    debugPrint('$songs');
    var record = state.record;
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserRecordStatusKey.recommend.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );

      var recommendResponse =
          await recommendRepo.generateRecommendPlaylist(songs);
      var recommends = <SongInfo>[];
      for (String id in recommendResponse) {
        final response = await songRepo.getInfo(id);
        final song = convertSongInfoModel(response);
        if (song != null) recommends.add(song);
      }
      record = record?.copyWith(
        recommendSongs: recommends,
      );

      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserRecordStatusKey.recommend.name,
          ], status: [
            Status.success,
          ]),
          record: () => record,
        ),
      );
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserRecordStatusKey.recommend.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(
          Exception("UserRecordBloc _recommendPlaylist error ${e.toString()}"),
          StackTrace.current);
    }
    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserRecordStatusKey.recommend.name,
        ], status: [
          Status.idle,
        ]),
      ),
    );
  }

  FutureOr<void> _userRecordResetEvent(
      UserRecordResetEvent event, Emitter<UserRecordState> emit) {
    emit(UserRecordState(
      status: {
        UserRecordStatusKey.global.name: Status.idle,
      },
    ));
  }
}
