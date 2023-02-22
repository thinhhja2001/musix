import 'package:flutter/material.dart';

import '../../../global/widgets/widgets.dart';
import '../../models/models.dart';

class VideoSelectionWidget extends StatelessWidget {
  final String title;
  final VideoDetail video;
  const VideoSelectionWidget({
    Key? key,
    required this.title,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RotatedTextWidget(text: title),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          alignment: Alignment.center,
          child: VideoPlayerWidget(
            videoUrl: video.videoUrl,
            authorVideo: video.artistsNames,
            titleVideo: video.title,
          ),
        ))
      ],
    );
  }
}
