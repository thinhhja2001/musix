import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain_auth/logic/auth_bloc.dart';
import '../../utils/utils.dart';
import '../entities/entities.dart';
import '../repo/user_music_repo.dart';
import '../utils/convert_model_entity.dart';

class UserMusicBloc extends Bloc<UserMusicEvent, UserMusicState> {
  UserMusicBloc({
    required UserMusicState initialState,
    required this.authBloc,
    required this.userMusicRepo,
  }) : super(initialState) {
    authBloc.stream.listen((authState) {
      if (authState.username != null && authState.jwtToken != null) {
        username = authState.username!;
        token = authState.jwtToken!;
      }
    });
    on<GetUserMusicEvent>(_getUserMusic);
    on<FavoritePlaylistEvent>(_favoritePlaylist);
    on<FavoriteArtistEvent>(_favoriteArtist);
    on<FavoriteSongEvent>(_favoriteSong);
    on<DislikePlaylistEvent>(_dislikePlaylist);
    on<DislikeArtistEvent>(_dislikeArtist);
    on<DislikeSongEvent>(_dislikeSong);
    on<CreateOwnPlaylistEvent>(_createOwnPlaylist);
    on<ChangeOwnPlaylistEvent>(_changeOwnPlaylist);
    on<UploadThumbnailOwnPlaylistEvent>(_uploadThumbnailOwnPlaylist);
    on<UploadSongOwnPlaylistEvent>(_uploadSongOwnPlaylist);
    on<RemoveOwnPlaylistEvent>(_removeOwnPlaylist);
  }
  final AuthBloc authBloc;
  final UserMusicRepo userMusicRepo;
  late final String token;
  late final String username;

  //----------------------------------------------------------------------------
  @override
  void onError(Object error, StackTrace stackTrace) {
    DebugLogger debugLogger = DebugLogger();
    debugLogger.log('$error\n $stackTrace');
    super.onError(error, stackTrace);
  }

  FutureOr<void> _getUserMusic(
      GetUserMusicEvent event, Emitter<UserMusicState> emit) async {
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.global.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var userMusicModel =
          await userMusicRepo.getUserMusic(token: token, username: username);

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.global.name,
        ], status: [
          Status.success,
        ]),
        music: convertUserMusicModelToUserMusic(userMusicModel),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.global.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(Exception("UserMusicBloc _getUserMusic error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.global.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(Exception("UserMusicBloc _getUserMusic error $e"),
          StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        UserMusicStatusKey.global.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _favoriteSong(
      FavoriteSongEvent event, Emitter<UserMusicState> emit) async {
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.song.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var gerneNames = event.genreNames?.join(", ");

      var songModels = await userMusicRepo.favoriteSong(
          token: token,
          username: username,
          id: event.id,
          title: event.title,
          artistNames: event.artistNames,
          genreNames: gerneNames);

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.song.name,
        ], status: [
          Status.success,
        ]),
        music: state.music?.copyWith(
          favoriteSongs: convertSongsModelToList(songModels),
        ),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.song.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(Exception("UserMusicBloc _favoriteSong error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.song.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(Exception("UserMusicBloc _favoriteSong error $e"),
          StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        UserMusicStatusKey.song.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _dislikeSong(
      DislikeSongEvent event, Emitter<UserMusicState> emit) async {
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.song.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var gerneNames = event.genreNames?.join(", ");

      var songModels = await userMusicRepo.dislikeSong(
          token: token,
          username: username,
          id: event.id,
          title: event.title,
          artistNames: event.artistNames,
          genreNames: gerneNames);

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.song.name,
        ], status: [
          Status.success,
        ]),
        music: state.music?.copyWith(
          dislikeSongs: convertSongsModelToList(songModels),
        ),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.song.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(Exception("UserMusicBloc _dislikeSong error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.song.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(
          Exception("UserMusicBloc _dislikeSong error $e"), StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        UserMusicStatusKey.song.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _favoriteArtist(
      FavoriteArtistEvent event, Emitter<UserMusicState> emit) async {
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.artist.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var artistModels = await userMusicRepo.favoriteArtist(
        token: token,
        username: username,
        id: event.id,
        name: event.name,
        alias: event.alias,
      );

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.artist.name,
        ], status: [
          Status.success,
        ]),
        music: state.music?.copyWith(
          favoriteArtists: convertArtistsModelToList(artistModels),
        ),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.artist.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(Exception("UserMusicBloc _favoriteArtist error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.artist.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(Exception("UserMusicBloc _favoriteArtist error $e"),
          StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        UserMusicStatusKey.artist.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _dislikeArtist(
      DislikeArtistEvent event, Emitter<UserMusicState> emit) async {
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.artist.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var artistModels = await userMusicRepo.favoriteArtist(
        token: token,
        username: username,
        id: event.id,
        name: event.name,
        alias: event.alias,
      );

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.artist.name,
        ], status: [
          Status.success,
        ]),
        music: state.music?.copyWith(
          dislikeArtists: convertArtistsModelToList(artistModels),
        ),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.artist.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(Exception("UserMusicBloc _dislikeArtist error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.artist.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(Exception("UserMusicBloc _dislikeArtist error $e"),
          StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        UserMusicStatusKey.artist.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _favoritePlaylist(
      FavoritePlaylistEvent event, Emitter<UserMusicState> emit) async {
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.playlist.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var gerneNames = event.genreNames?.join(", ");

      var playlistModels = await userMusicRepo.favoritePlaylist(
        token: token,
        username: username,
        id: event.id,
        title: event.title,
        artistNames: event.artistNames,
        genreNames: gerneNames,
        countSongs: event.countSong,
      );

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.playlist.name,
        ], status: [
          Status.success,
        ]),
        music: state.music?.copyWith(
          favoritePlaylists: convertPlaylistsModelToList(playlistModels),
        ),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.playlist.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(
          Exception("UserMusicBloc _favoritePlaylist error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.playlist.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(Exception("UserMusicBloc _favoritePlaylist error $e"),
          StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        UserMusicStatusKey.playlist.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _dislikePlaylist(
      DislikePlaylistEvent event, Emitter<UserMusicState> emit) async {
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.playlist.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var gerneNames = event.genreNames?.join(", ");

      var playlistModels = await userMusicRepo.favoritePlaylist(
        token: token,
        username: username,
        id: event.id,
        title: event.title,
        artistNames: event.artistNames,
        genreNames: gerneNames,
        countSongs: event.countSong,
      );

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.playlist.name,
        ], status: [
          Status.success,
        ]),
        music: state.music?.copyWith(
          dislikePlaylists: convertPlaylistsModelToList(playlistModels),
        ),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.playlist.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(
          Exception("UserMusicBloc _dislikePlaylist error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.playlist.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(Exception("UserMusicBloc _dislikePlaylist error $e"),
          StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        UserMusicStatusKey.playlist.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _createOwnPlaylist(
      CreateOwnPlaylistEvent event, Emitter<UserMusicState> emit) async {
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.ownPlaylist.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var ownPlaylistsModel = await userMusicRepo.createOwnPlaylist(
        token: token,
        username: username,
        title: event.title,
        sortDescription: event.sortDescription,
      );

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.ownPlaylist.name,
        ], status: [
          Status.success,
        ]),
        music: state.music?.copyWith(
          ownPlaylists: convertOwnPlaylistsModelToList(ownPlaylistsModel),
        ),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.ownPlaylist.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(
          Exception("UserMusicBloc _createOwnPlaylist error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.ownPlaylist.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(Exception("UserMusicBloc _createOwnPlaylist error $e"),
          StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        UserMusicStatusKey.ownPlaylist.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _changeOwnPlaylist(
      ChangeOwnPlaylistEvent event, Emitter<UserMusicState> emit) async {
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.ownPlaylist.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var ownPlaylistsModel = await userMusicRepo.changeOwnPlaylist(
        token: token,
        username: username,
        playlistId: event.playlistId,
        title: event.title,
        sortDescription: event.sortDescription,
      );

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.ownPlaylist.name,
        ], status: [
          Status.success,
        ]),
        music: state.music?.copyWith(
          ownPlaylists: convertOwnPlaylistsModelToList(ownPlaylistsModel),
        ),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.ownPlaylist.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(
          Exception("UserMusicBloc _changeOwnPlaylist error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.ownPlaylist.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(Exception("UserMusicBloc _changeOwnPlaylist error $e"),
          StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        UserMusicStatusKey.ownPlaylist.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _uploadThumbnailOwnPlaylist(
      UploadThumbnailOwnPlaylistEvent event,
      Emitter<UserMusicState> emit) async {
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.ownPlaylist.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var ownPlaylistsModel = await userMusicRepo.uploadThumbnailOwnPlaylist(
        token: token,
        username: username,
        playlistId: event.playlistId,
        thumbnail: event.thumbnail,
      );

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.ownPlaylist.name,
        ], status: [
          Status.success,
        ]),
        music: state.music?.copyWith(
          ownPlaylists: convertOwnPlaylistsModelToList(ownPlaylistsModel),
        ),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.ownPlaylist.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(
          Exception(
              "UserMusicBloc _uploadThumbnailOwnPlaylist error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.ownPlaylist.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(Exception("UserMusicBloc _uploadThumbnailOwnPlaylist error $e"),
          StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        UserMusicStatusKey.ownPlaylist.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _uploadSongOwnPlaylist(
      UploadSongOwnPlaylistEvent event, Emitter<UserMusicState> emit) async {
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.ownPlaylist.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var gerneNames = event.genreNames?.join(", ");

      var ownPlaylistsModel = await userMusicRepo.uploadSongOwnPlaylist(
        token: token,
        username: username,
        playlistId: event.playlistId,
        id: event.id,
        title: event.title,
        artistNames: event.artistNames,
        genreNames: gerneNames,
      );

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.ownPlaylist.name,
        ], status: [
          Status.success,
        ]),
        music: state.music?.copyWith(
          ownPlaylists: convertOwnPlaylistsModelToList(ownPlaylistsModel),
        ),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.ownPlaylist.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(
          Exception(
              "UserMusicBloc _uploadSongOwnPlaylist error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.ownPlaylist.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(Exception("UserMusicBloc _uploadSongOwnPlaylist error $e"),
          StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        UserMusicStatusKey.ownPlaylist.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _removeOwnPlaylist(
      RemoveOwnPlaylistEvent event, Emitter<UserMusicState> emit) async {
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.ownPlaylist.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var ownPlaylistsModel = await userMusicRepo.removeOwnPlaylist(
        token: token,
        username: username,
        playlistId: event.playlistId,
      );

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.ownPlaylist.name,
        ], status: [
          Status.success,
        ]),
        music: state.music?.copyWith(
          ownPlaylists: convertOwnPlaylistsModelToList(ownPlaylistsModel),
        ),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.ownPlaylist.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(
          Exception("UserMusicBloc _removeOwnPlaylist error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.ownPlaylist.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(Exception("UserMusicBloc _removeOwnPlaylist error $e"),
          StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        UserMusicStatusKey.ownPlaylist.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }
}
