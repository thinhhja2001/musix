import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/convert_artist.dart';

import '../../config/exporter/repo_exporter.dart';
import '../../utils/utils.dart';
import '../entities/entities.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  ArtistBloc({
    required ArtistState initialState,
    required this.artistRepo,
  }) : super(initialState) {
    on<ArtistGetInfoEvent>(_getInfo);
    on<ArtistBackInfoEvent>(_backInfo);
  }

  final ArtistRepo artistRepo;

  //----------------------------------------------------------------------------
  @override
  void onError(Object error, StackTrace stackTrace) {
    DebugLogger debugLogger = DebugLogger();
    debugLogger.log('$error\n $stackTrace');
    super.onError(error, stackTrace);
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _getInfo(
      ArtistGetInfoEvent event, Emitter<ArtistState> emit) async {
    try {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            ArtistStatusKey.global.key,
            ArtistStatusKey.info.key,
          ],
          status: [
            Status.loading,
            Status.loading,
          ],
        ),
      ));

      final response = await artistRepo.getArtistInfo(event.alias);
      final info = convertArtistFromModel(response.data);
      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              ArtistStatusKey.global.key,
              ArtistStatusKey.info.key,
            ],
            status: [
              Status.idle,
              Status.success,
            ],
          ),
          info: info,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            ArtistStatusKey.global.key,
            ArtistStatusKey.info.key,
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
                ArtistStatusKey.global.key,
                ArtistStatusKey.info.key,
              ],
              status: [
                Status.idle,
                Status.idle,
              ],
            ),
          ),
        ));
  }

  FutureOr<void> _backInfo(
      ArtistBackInfoEvent event, Emitter<ArtistState> emit) {
    emit(ArtistState(
      status: updateMapStatus(
        source: state.status,
        keys: [
          ArtistStatusKey.global.key,
          ArtistStatusKey.artists.key,
        ],
        status: [
          Status.idle,
          Status.idle,
        ],
      ),
      artists: state.artists,
    ));
  }
}
