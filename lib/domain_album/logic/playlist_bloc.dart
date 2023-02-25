import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../entities/entities.dart';

import '../../config/exporter/repo_exporter.dart';
import '../../utils/utils.dart';
import '../utils/convert_playlist/convert_mini_playlist.dart';
import '../utils/convert_playlist/convert_playlist.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  PlaylistBloc({
    required PlaylistState initialState,
    required this.playlistRepo,
    required this.hubRepo,
  }) : super(initialState) {
    on<PlaylistGetInfoEvent>(_getPlaylist);
    on<PlaylistBackInfoEvent>(_backInfo);
    on<PlaylistGetListEvent>(_getPlaylists);
    on<PlaylistBackListEvent>(_backList);
  }

  final PlaylistRepo playlistRepo;
  final HubRepo hubRepo;

  //----------------------------------------------------------------------------
  @override
  void onError(Object error, StackTrace stackTrace) {
    DebugLogger debugLogger = DebugLogger();
    debugLogger.log('$error\n $stackTrace');
    super.onError(error, stackTrace);
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _getPlaylist(
      PlaylistGetInfoEvent event, Emitter<PlaylistState> emit) async {
    try {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            PlaylistStatusKey.global.key,
            PlaylistStatusKey.info.key,
          ],
          status: [
            Status.loading,
            Status.loading,
          ],
        ),
      ));

      final response = await playlistRepo.getPlaylistById(event.id);
      final playlist = convertPlaylistModel(response.data);
      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              PlaylistStatusKey.global.key,
              PlaylistStatusKey.info.key,
            ],
            status: [
              Status.idle,
              Status.success,
            ],
          ),
          playlist: playlist,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            PlaylistStatusKey.global.key,
            PlaylistStatusKey.info.key,
          ],
          status: [
            Status.idle,
            Status.error,
          ],
        ),
      ));
      addError(
          Exception("PlaylistLogic _getPlaylist error"), StackTrace.current);
    }
    await Future.delayed(
      const Duration(milliseconds: 300),
    ).whenComplete(() => emit(
          state.copyWith(
            status: updateMapStatus(
              source: state.status,
              keys: [
                PlaylistStatusKey.global.key,
                PlaylistStatusKey.info.key,
              ],
              status: [
                Status.idle,
                Status.idle,
              ],
            ),
          ),
        ));
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _getPlaylists(
      PlaylistGetListEvent event, Emitter<PlaylistState> emit) async {
    try {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            PlaylistStatusKey.global.key,
            PlaylistStatusKey.playlists.key,
          ],
          status: [
            Status.loading,
            Status.loading,
          ],
        ),
      ));

      final response = await hubRepo.getHubDetailed(event.hubId);
      DebugLogger().log(response);
      final topics = response.data?.sections
          ?.map((e) => convertTopicFromHubSection(e))
          .where((element) => element != null)
          .toList();
      topics
          ?.map((e) => DebugLogger().log('${e?.title} - ${e?.items?.length}'));
      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              PlaylistStatusKey.global.key,
              PlaylistStatusKey.playlists.key,
            ],
            status: [
              Status.idle,
              Status.success,
            ],
          ),
          topics: topics,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            PlaylistStatusKey.global.key,
            PlaylistStatusKey.playlists.key,
          ],
          status: [
            Status.idle,
            Status.error,
          ],
        ),
      ));
      addError(
          Exception("PlaylistLogic _getPlaylists error"), StackTrace.current);
    }
    await Future.delayed(
      const Duration(milliseconds: 300),
    ).whenComplete(() => emit(
          state.copyWith(
            status: updateMapStatus(
              source: state.status,
              keys: [
                PlaylistStatusKey.global.key,
                PlaylistStatusKey.playlists.key,
              ],
              status: [
                Status.idle,
                Status.idle,
              ],
            ),
          ),
        ));
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _backInfo(
      PlaylistBackInfoEvent event, Emitter<PlaylistState> emit) async {
    emit(PlaylistState(
      status: updateMapStatus(
        source: state.status,
        keys: [
          PlaylistStatusKey.global.key,
          PlaylistStatusKey.playlists.key,
        ],
        status: [
          Status.idle,
          Status.idle,
        ],
      ),
      topics: state.topics,
    ));
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _backList(
      PlaylistBackListEvent event, Emitter<PlaylistState> emit) async {
    emit(PlaylistState(
      status: updateMapStatus(
        source: state.status,
        keys: [
          PlaylistStatusKey.global.key,
        ],
        status: [
          Status.idle,
        ],
      ),
    ));
  }
}
