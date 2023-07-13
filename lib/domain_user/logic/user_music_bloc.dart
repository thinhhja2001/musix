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
      if (authState.username != null &&
          authState.jwtToken != null &&
          authState.jwtToken != "") {
        token = authState.jwtToken!;
      }
    });
    on<GetUserMusicEvent>(_getUserMusic);
    on<FavoritePlaylistEvent>(_favoritePlaylist);
    on<FavoriteArtistEvent>(_favoriteArtist);
    on<CheckSongEvent>(_checkSong);
    on<FavoriteSongEvent>(_favoriteSong);
    on<CheckPlaylistEvent>(_checkPlaylist);
    on<DislikePlaylistEvent>(_dislikePlaylist);
    on<CheckArtistEvent>(_checkArtist);
    on<DislikeArtistEvent>(_dislikeArtist);
    on<DislikeSongEvent>(_dislikeSong);
    on<CreateOwnPlaylistEvent>(_createOwnPlaylist);
    on<ChangeOwnPlaylistEvent>(_changeOwnPlaylist);
    on<UploadThumbnailOwnPlaylistEvent>(_uploadThumbnailOwnPlaylist);
    on<UploadSongOwnPlaylistEvent>(_uploadSongOwnPlaylist);
    on<RemoveSongOwnPlaylistEvent>(_removeSongOwnPlaylist);
    on<RemoveOwnPlaylistEvent>(_removeOwnPlaylist);
    on<ResetUserMusicEvent>(_resetEvent);
  }
  final AuthBloc authBloc;
  final UserMusicRepo userMusicRepo;
  String token = "";

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
      var userMusicModel = await userMusicRepo.getUserMusic(token: token);

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

  FutureOr<void> _checkSong(
      CheckSongEvent event, Emitter<UserMusicState> emit) {
    bool isExist = false;
    if (event.isFavorite) {
      isExist = state.music?.dislikeSongs?.contains(event.id) ?? false;
    } else {
      isExist = state.music?.favoriteSongs?.contains(event.id) ?? false;
    }
    if (isExist) {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.song.name,
          ], status: [
            Status.error,
          ]),
          error: ResponseException(statusCode: event.isFavorite ? 1000 : 1001),
        ),
      );
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.song.name,
          ], status: [
            Status.idle,
          ]),
        ),
      );
    } else {
      if (event.isFavorite) {
        add(FavoriteSongEvent(
            id: event.id,
            title: event.title,
            artistNames: event.artistNames,
            genreNames: event.genreNames));
      } else {
        add(DislikeSongEvent(
            id: event.id,
            title: event.title,
            artistNames: event.artistNames,
            genreNames: event.genreNames));
      }
    }
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

      var dislikeSongs = state.music?.dislikeSongs;
      if (event.isRemoveDislike == true) {
        var dislikeSongModels = await userMusicRepo.dislikeSong(
            token: token,
            id: event.id,
            title: event.title,
            artistNames: event.artistNames,
            genreNames: gerneNames);
        dislikeSongs = convertSongsModelToList(dislikeSongModels);
      }

      var songModels = await userMusicRepo.favoriteSong(
          token: token,
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
          dislikeSongs: dislikeSongs,
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

      var favoriteSongs = state.music?.favoriteSongs;
      if (event.isRemoveFavorite == true) {
        var favoriteSongModels = await userMusicRepo.favoriteSong(
            token: token,
            id: event.id,
            title: event.title,
            artistNames: event.artistNames,
            genreNames: gerneNames);
        favoriteSongs = convertSongsModelToList(favoriteSongModels);
      }

      var songModels = await userMusicRepo.dislikeSong(
          token: token,
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
          favoriteSongs: favoriteSongs,
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

  FutureOr<void> _checkArtist(
      CheckArtistEvent event, Emitter<UserMusicState> emit) {
    bool isExist = false;
    if (event.isFavorite) {
      isExist = state.music?.dislikeArtists?.contains(event.alias) ?? false;
    } else {
      isExist = state.music?.favoriteArtists?.contains(event.alias) ?? false;
    }
    if (isExist) {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.artist.name,
          ], status: [
            Status.error,
          ]),
          error: ResponseException(statusCode: event.isFavorite ? 1000 : 1001),
        ),
      );
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.artist.name,
          ], status: [
            Status.idle,
          ]),
        ),
      );
    } else {
      if (event.isFavorite) {
        add(FavoriteArtistEvent(
          id: event.id,
          name: event.name,
          alias: event.alias,
        ));
      } else {
        add(DislikeArtistEvent(
          id: event.id,
          name: event.name,
          alias: event.alias,
        ));
      }
    }
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

      var dislikeArtists = state.music?.dislikeArtists;
      if (event.isRemoveDislike == true) {
        var dislikeArtistModels = await userMusicRepo.dislikeArtist(
          token: token,
          id: event.id,
          name: event.name,
          alias: event.alias,
        );
        dislikeArtists = convertArtistsModelToList(dislikeArtistModels);
      }

      var artistModels = await userMusicRepo.favoriteArtist(
        token: token,
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
          dislikeArtists: dislikeArtists,
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

      var favoriteArtists = state.music?.favoriteArtists;
      if (event.isRemoveFavorite == true) {
        var favoritesArtistModels = await userMusicRepo.favoriteArtist(
          token: token,
          id: event.id,
          name: event.name,
          alias: event.alias,
        );
        favoriteArtists = convertArtistsModelToList(favoritesArtistModels);
      }

      var artistModels = await userMusicRepo.dislikeArtist(
        token: token,
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
          favoriteArtists: favoriteArtists,
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

  FutureOr<void> _checkPlaylist(
      CheckPlaylistEvent event, Emitter<UserMusicState> emit) {
    bool isExist = false;
    if (event.isFavorite) {
      isExist = state.music?.dislikePlaylists?.contains(event.id) ?? false;
    } else {
      isExist = state.music?.favoritePlaylists?.contains(event.id) ?? false;
    }
    if (isExist) {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.playlist.name,
          ], status: [
            Status.error,
          ]),
          error: ResponseException(statusCode: event.isFavorite ? 1000 : 1001),
        ),
      );
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            UserMusicStatusKey.playlist.name,
          ], status: [
            Status.idle,
          ]),
        ),
      );
    } else {
      if (event.isFavorite) {
        add(FavoritePlaylistEvent(
          id: event.id,
          title: event.title,
          artistNames: event.artistNames,
          genreNames: event.genreNames,
        ));
      } else {
        add(DislikePlaylistEvent(
          id: event.id,
          title: event.title,
          artistNames: event.artistNames,
          genreNames: event.genreNames,
        ));
      }
    }
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

      var dislikePlaylists = state.music?.dislikePlaylists;
      if (event.isRemoveDislike == true) {
        var dislikePlaylistModels = await userMusicRepo.favoritePlaylist(
          token: token,
          id: event.id,
          title: event.title,
          artistNames: event.artistNames,
          genreNames: gerneNames,
          countSongs: event.countSong,
        );
        dislikePlaylists = convertPlaylistsModelToList(dislikePlaylistModels);
      }

      var playlistModels = await userMusicRepo.favoritePlaylist(
        token: token,
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
          dislikePlaylists: dislikePlaylists,
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

      var favoritePlaylists = state.music?.favoritePlaylists;
      if (event.isRemoveFavorite == true) {
        var favoritePlaylistModels = await userMusicRepo.favoritePlaylist(
          token: token,
          id: event.id,
          title: event.title,
          artistNames: event.artistNames,
          genreNames: gerneNames,
          countSongs: event.countSong,
        );
        favoritePlaylists = convertPlaylistsModelToList(favoritePlaylistModels);
      }

      var playlistModels = await userMusicRepo.dislikePlaylist(
        token: token,
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
          favoritePlaylists: favoritePlaylists,
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
      List<OwnPlaylist> ownPlaylists = [];
      for (var playlistId in event.playlistIds) {
        var ownPlaylistsModel = await userMusicRepo.uploadSongOwnPlaylist(
          token: token,
          playlistId: playlistId,
          id: event.id,
          title: event.title,
          artistNames: event.artistNames,
          genreNames: gerneNames,
        );
        ownPlaylists = convertOwnPlaylistsModelToList(ownPlaylistsModel);
      }

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.ownPlaylist.name,
        ], status: [
          Status.success,
        ]),
        music: state.music?.copyWith(
          ownPlaylists: ownPlaylists,
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

  FutureOr<void> _removeSongOwnPlaylist(
      RemoveSongOwnPlaylistEvent event, Emitter<UserMusicState> emit) async {
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
              "UserMusicBloc _removeSongOwnPlaylist error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          UserMusicStatusKey.ownPlaylist.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(Exception("UserMusicBloc _removeSongOwnPlaylist error $e"),
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

  FutureOr<void> _resetEvent(
      ResetUserMusicEvent event, Emitter<UserMusicState> emit) {
    emit(UserMusicState(
      status: {
        UserMusicStatusKey.global.name: Status.idle,
      },
    ));
  }
}
