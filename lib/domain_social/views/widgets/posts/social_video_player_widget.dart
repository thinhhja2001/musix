import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import '../../../../theme/color.dart';

class SocialVideoPlayerWidget extends StatelessWidget {
  const SocialVideoPlayerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final ChewieController controller;
  final barHeight = 48.0 * 1.5;

  Widget buildVideoPlayer() => Chewie(controller: controller);
  @override
  Widget build(BuildContext context) {
    return controller.videoPlayerController.value.isInitialized
        ? Container(color: Colors.black, child: Chewie(controller: controller))
        : const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(
                // color: ColorTheme.primary,
                color: Colors.yellow,
              ),
            ),
          );
  }
}
