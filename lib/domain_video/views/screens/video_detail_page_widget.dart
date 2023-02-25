import 'package:flutter/material.dart';
import 'package:musix/domain_video/views/widgets/video_player/video_detail_card_widget.dart';

class VideoDetailPageWidget extends StatelessWidget {
  const VideoDetailPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: VideoDetailCardWidget());
  }
}
