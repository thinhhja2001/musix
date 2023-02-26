import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/utils.dart';
import '../entities/entities.dart';
import '../repo/hub_repo/hub_repo.dart';
import '../utils/utils.dart';

class HubBloc extends Bloc<HubEvent, HubState> {
  HubBloc({
    required HubState initialState,
    required this.hubRepo,
  }) : super(initialState) {
    on<HubGetInfoEvent>(_getInfo);
    on<HubBackInfoEvent>(_backInfo);
  }

  final HubRepo hubRepo;

  //----------------------------------------------------------------------------
  @override
  void onError(Object error, StackTrace stackTrace) {
    DebugLogger debugLogger = DebugLogger();
    debugLogger.log('$error\n $stackTrace');
    super.onError(error, stackTrace);
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _getInfo(HubGetInfoEvent event, Emitter<HubState> emit) async {
    try {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            HubStatusKey.global.key,
            HubStatusKey.info.key,
          ],
          status: [
            Status.loading,
            Status.loading,
          ],
        ),
      ));

      final response = await hubRepo.getHubDetailed(event.id);
      final info = convertHubFromHubModel(response.data!);
      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              HubStatusKey.global.key,
              HubStatusKey.info.key,
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
            HubStatusKey.global.key,
            HubStatusKey.info.key,
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
                HubStatusKey.global.key,
                HubStatusKey.info.key,
              ],
              status: [
                Status.idle,
                Status.idle,
              ],
            ),
          ),
        ));
  }

  FutureOr<void> _backInfo(HubBackInfoEvent event, Emitter<HubState> emit) {
    emit(HubState(
      status: updateMapStatus(
        source: state.status,
        keys: [
          HubStatusKey.global.key,
        ],
        status: [
          Status.idle,
        ],
      ),
    ));
  }
}
