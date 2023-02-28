import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain_song/repository/repository.dart';
import '../entities/state/video_key.dart';
import '../utils/convert_video.dart';
import '../utils/methods.dart';
import '../../utils/utils.dart';
import 'package:video_player/video_player.dart';

import '../entities/event/video_event.dart';
import '../entities/state/video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc({
    required VideoState initialState,
    required this.videoRepositoryImpl,
  }) : super(initialState) {
    on<VideoGetVideoShortEvent>(_getVideoShortEvent);
    on<VideoGetVideoDetailEvent>(_getVideoDetailEvent);
    on<VideoBackEvent>(_back);
  }
  final VideoRepositoryImpl videoRepositoryImpl;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  //----------------------------------------------------------------------------
  @override
  void onError(Object error, StackTrace stackTrace) {
    DebugLogger debugLogger = DebugLogger();
    debugLogger.log('$error\n $stackTrace');
    super.onError(error, stackTrace);
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _getVideoShortEvent(
      VideoGetVideoShortEvent event, Emitter emit) async {}

  //----------------------------------------------------------------------------
  FutureOr<void> _getVideoDetailEvent(
      VideoGetVideoDetailEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [VideoStatusKey.global.key],
          status: [Status.loading],
        ),
        isVideoLoaded: false,
      ),
    );
    final response = await videoRepositoryImpl.getInfo(event.id);
    final videoDetail = convertVideoDetailModel(response);
    videoPlayerController =
        VideoPlayerController.network(videoDetail.videoUrl ?? "");
    //Must call or we will get videoPlayerController doesn't initialize error
    await videoPlayerController.initialize();
    chewieController = createChewieController(
      controller: videoPlayerController,
      videoDetail: videoDetail,
    );
    chewieController.videoPlayerController.play();
    emit(
      state.copyWith(
        status: updateMapStatus(
            source: state.status,
            keys: [VideoStatusKey.global.key],
            status: [Status.success]),
        videoDetail: videoDetail,
        chewieController: chewieController,
        isVideoLoaded: true,
      ),
    );
  }

  FutureOr<void> _back(VideoBackEvent event, Emitter emit) async {
    print("back event called");
    chewieController.videoPlayerController.pause();
    emit(
      state.copyWith(
        videoDetail: null,
        chewieController: null,
        isVideoLoaded: false,
      ),
    );
  }
}
