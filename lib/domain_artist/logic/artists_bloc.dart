import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_artist/entities/entities.dart';

import '../../utils/utils.dart';
import '../utils/convert_mini_artist.dart';

class ArtistsBloc extends Bloc<ArtistsEvent, ArtistsState> {
  ArtistsBloc({
    required ArtistsState initialState,
    required this.artistRepo,
  }) : super(initialState) {
    on<GetArtistsEvent>(_getArtists);
    on<RemoveArtistEvent>(_removeArtist);
    on<BackArtistsEvent>(_backArtist);
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
  FutureOr<void> _getArtists(
      GetArtistsEvent event, Emitter<ArtistsState> emit) async {
    try {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            ArtistsStatusKey.global.name,
          ],
          status: [
            Status.loading,
          ],
        ),
        title: event.title,
      ));
      List<MiniArtist> artists = [];
      for (String alias in event.aliasList) {
        final response = await artistRepo.getArtistInfo(alias);
        final artist = convertMiniArtist(response.data);
        artists.add(artist!);
      }

      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              ArtistsStatusKey.global.name,
            ],
            status: [
              Status.success,
            ],
          ),
          artists: artists,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            ArtistsStatusKey.global.name,
          ],
          status: [
            Status.error,
          ],
        ),
      ));
      addError(Exception("ArtistsLogic _getArtists error"), StackTrace.current);
    }
    await Future.delayed(
      const Duration(milliseconds: 300),
    ).whenComplete(() => emit(state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              ArtistsStatusKey.global.name,
            ],
            status: [
              Status.idle,
            ],
          ),
        )));
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _removeArtist(
      RemoveArtistEvent event, Emitter<ArtistsState> emit) async {
    try {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            ArtistsStatusKey.global.name,
          ],
          status: [
            Status.loading,
          ],
        ),
      ));
      var artists = state.artists;
      artists?.removeWhere((element) => element.alias == event.alias);

      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              ArtistsStatusKey.global.name,
            ],
            status: [
              Status.success,
            ],
          ),
          artists: artists,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            ArtistsStatusKey.global.name,
          ],
          status: [
            Status.error,
          ],
        ),
      ));
      addError(
          Exception("ArtistsLogic _removeArtist error"), StackTrace.current);
    }
    await Future.delayed(
      const Duration(milliseconds: 300),
    ).whenComplete(() => emit(state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              ArtistsStatusKey.global.name,
            ],
            status: [
              Status.idle,
            ],
          ),
        )));
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _backArtist(
      BackArtistsEvent event, Emitter<ArtistsState> emit) async {
    emit(ArtistsState(
      status: updateMapStatus(
        source: state.status,
        keys: [
          ArtistsStatusKey.global.name,
        ],
        status: [
          Status.idle,
        ],
      ),
    ));
  }
}
