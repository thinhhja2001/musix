import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final ChewieController controller;
  final barHeight = 48.0 * 1.5;

  Widget buildVideo() => Stack(
        children: [
          buildVideoPlayer(),
        ],
      );

  Widget buildVideoPlayer() => Chewie(controller: controller);
  @override
  Widget build(BuildContext context) {
    return controller.videoPlayerController.value.isInitialized
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: AspectRatio(
                    aspectRatio:
                        controller.videoPlayerController.value.aspectRatio,
                    child: buildVideo()),
              ),
            ],
          )
        : const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(
                color: ColorTheme.primary,
              ),
            ),
          );
  }
}
