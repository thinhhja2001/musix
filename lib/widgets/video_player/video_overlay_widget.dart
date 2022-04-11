import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/utils.dart';
import 'package:video_player/video_player.dart';

class VideoOverlayWidget extends StatefulWidget {
  const VideoOverlayWidget({Key? key, required this.controller})
      : super(key: key);
  final VideoPlayerController controller;

  @override
  State<VideoOverlayWidget> createState() => _VideoOverlayWidgetState();
}

class _VideoOverlayWidgetState extends State<VideoOverlayWidget> {
  IconData pauseIcon = Icons.pause_circle_outline;
  IconData playIcon = Icons.play_circle_outline;
  //true for playing, false for pausing
  bool currentPlayState = false;
  @override
  Widget build(BuildContext context) {
    void onPlayButtonClicked() {
      setState(() {
        currentPlayState = !currentPlayState;
        currentPlayState == true
            ? widget.controller.play()
            : widget.controller.pause();
      });
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pay for the love",
                    style: kDefaultTitleStyle,
                  ),
                  Text(
                    "One blue",
                    style: kDefaultTitleStyle.copyWith(color: kPrimaryColor),
                  ),
                ],
              ),
            ),
            Center(
                child: IconButton(
                    onPressed: onPlayButtonClicked,
                    icon: Icon(
                      currentPlayState == true ? pauseIcon : playIcon,
                      size: 30,
                      color: Colors.white,
                    ))),
            const Spacer(),
            buildIndicator(),
            buildTimer()
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() => VideoProgressIndicator(
        widget.controller,
        allowScrubbing: true,
        colors: const VideoProgressColors(playedColor: kPrimaryColor),
      );

  Widget buildTimer() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueListenableBuilder(
            valueListenable: widget.controller,
            builder: (context, VideoPlayerValue value, child) {
              return Text(
                formatDuration(value.position.inSeconds),
                style: kDefaultTitleStyle,
              );
            },
          ),
          Text(
            formatDuration(widget.controller.value.duration.inSeconds),
            style: kDefaultTitleStyle,
          )
        ],
      );
}
