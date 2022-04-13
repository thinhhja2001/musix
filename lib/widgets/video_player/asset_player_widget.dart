import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/widgets/customs/custom_material_controls.dart';
import 'package:video_player/video_player.dart';

import '../video_player/video_player_widget.dart';

class AssetPlayerWidget extends StatefulWidget {
  const AssetPlayerWidget({Key? key}) : super(key: key);

  @override
  State<AssetPlayerWidget> createState() => _AssetPlayerWidgetState();
}

class _AssetPlayerWidgetState extends State<AssetPlayerWidget> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/video.mp4')
      ..initialize().then((_) {
        _chewieController = ChewieController(
            videoPlayerController: _controller,
            showControls: true,
            customControls: const CustomMaterialControls(
              song: "Bước qua nhau",
              singer: "Vũ",
            ),
            materialProgressColors: ChewieProgressColors(
                playedColor: kPrimaryColor,
                bufferedColor: Colors.grey,
                backgroundColor: Colors.white),
            allowFullScreen: true);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidget(controller: _chewieController);
  }
}
