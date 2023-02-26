import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';
import '../video_detail.dart';

import '../../../utils/utils.dart';

class VideoState extends Equatable {
  final Map<String, Status>? status;
  final VideoDetail? videoDetail;
  final ChewieController? chewieController;
  const VideoState({
    this.status,
    this.chewieController,
    this.videoDetail,
  });
  @override
  List<Object?> get props => [
        status,
        videoDetail,
        chewieController,
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
      );
}
