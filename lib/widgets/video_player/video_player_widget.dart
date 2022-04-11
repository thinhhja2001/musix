import 'package:flutter/material.dart';
import 'package:musix/widgets/video_player/video_overlay_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final VideoPlayerController controller;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  bool isOverlayShow = true;
  Widget buildVideo() => Stack(
        children: [
          buildVideoPlayer(),
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: isOverlayShow ? true : false,
            child: VideoOverlayWidget(controller: widget.controller),
          )
        ],
      );

  Widget buildVideoPlayer() => ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: VideoPlayer(widget.controller));
  @override
  Widget build(BuildContext context) {
    return widget.controller.value.isInitialized
        ? Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isOverlayShow = !isOverlayShow;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: AspectRatio(
                          aspectRatio: widget.controller.value.aspectRatio,
                          child: buildVideo()),
                    ),
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
