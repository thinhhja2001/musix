import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../theme/theme.dart';
import '../entities/video_detail.dart';
import '../views/widgets/custom/custom_material_control.dart';

ChewieController createChewieController({
  required VideoPlayerController controller,
  required VideoDetail videoDetail,
  Widget? customControls,
}) {
  return ChewieController(
      videoPlayerController: controller,
      showControls: true,
      customControls: customControls ??
          CustomMaterialControls(
            title: videoDetail.title ?? "",
            singer: videoDetail.artistsNames ?? "",
          ),
      materialProgressColors: ChewieProgressColors(
        playedColor: ColorTheme.primary,
        bufferedColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
      allowFullScreen: true);
}
