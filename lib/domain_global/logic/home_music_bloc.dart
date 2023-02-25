import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_global/entities/entities.dart';
import 'package:musix/domain_global/utils/convert_home_music/convert_home_music.dart';

import '../../config/exporter/repo_exporter.dart';
import '../../domain_hub/utils/utils.dart';
import '../../utils/utils.dart';

class HomeMusicBloc extends Bloc<HomeMusicEvent, HomeMusicState> {
  HomeMusicBloc({
    required HomeMusicState initialState,
    required this.homeMusicRepo,
    required this.hubRepo,
  }) : super(initialState) {
    on<HomeMusicGetEvent>(_getHomeMusic);
  }

  final HomeMusicRepo homeMusicRepo;
  final HubRepo hubRepo;

  //----------------------------------------------------------------------------
  @override
  void onError(Object error, StackTrace stackTrace) {
    DebugLogger debugLogger = DebugLogger();
    debugLogger.log('$error\n $stackTrace');
    super.onError(error, stackTrace);
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _getHomeMusic(
      HomeMusicGetEvent event, Emitter<HomeMusicState> emit) async {
    try {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            HomeMusicStatusKey.global.key,
          ],
          status: [
            Status.loading,
          ],
        ),
      ));

      final response = await homeMusicRepo.getHomeModel();
      final hubResponse = await hubRepo.getHomeHub();
      final hubs = convertHubFromGetHomeHub(hubResponse);
      var homeMusic = convertFromGetHomeModel(response);
      homeMusic = homeMusic?.copyWith(hubs: hubs);

      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              HomeMusicStatusKey.global.key,
            ],
            status: [
              Status.success,
            ],
          ),
          homeMusic: homeMusic,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              HomeMusicStatusKey.global.key,
            ],
            status: [
              Status.error,
            ],
          ),
        ),
      );
      addError(Exception("HomeMusicBloc _getHomeMusic error $e"),
          StackTrace.current);
    }

    await Future.delayed(
      const Duration(milliseconds: 300),
    ).whenComplete(() => emit(
          state.copyWith(
            status: updateMapStatus(
              source: state.status,
              keys: [
                HomeMusicStatusKey.global.key,
              ],
              status: [
                Status.idle,
              ],
            ),
          ),
        ));
  }
}
