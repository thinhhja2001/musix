import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final ChewieController controller;
  final barHeight = 48.0 * 1.5;
  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  Widget buildVideo() => Stack(
        children: [
          buildVideoPlayer(),
        ],
      );

  Widget buildVideoPlayer() => ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Chewie(controller: widget.controller));
  @override
  Widget build(BuildContext context) {
    return widget.controller.videoPlayerController.value.isInitialized
        ? Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: AspectRatio(
                        aspectRatio: widget
                            .controller.videoPlayerController.value.aspectRatio,
                        child: buildVideo()),
                  ),
                ),
              ],
            ),
          )
        : Expanded(
            child: Container(
                height: 200,
                child: const Center(child: CircularProgressIndicator())),
          );
  }
}
