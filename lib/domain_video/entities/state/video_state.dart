import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';
import 'package:musix/domain_video/entities/video_detail.dart';

import '../../../utils/utils.dart';

class VideoState extends Equatable {
  final Map<String, Status>? status;
  final VideoDetail? videoDetail;
  final ChewieController? chewieController;
  final bool? isVideoLoaded;
  const VideoState({
    this.status,
    this.chewieController,
    this.videoDetail,
    this.isVideoLoaded,
  });
  @override
  List<Object?> get props => [
        status,
        videoDetail,
        chewieController,
        isVideoLoaded,
      ];
  @override
  bool? get stringify => true;

  VideoState copyWith(
          {Map<String, Status>? status,
          VideoDetail? videoDetail,
          ChewieController? chewieController,
          bool? isVideoLoaded}) =>
      VideoState(
        status: status ?? this.status,
        videoDetail: videoDetail ?? this.videoDetail,
        chewieController: chewieController ?? this.chewieController,
        isVideoLoaded: isVideoLoaded ?? this.isVideoLoaded,
      );
}
