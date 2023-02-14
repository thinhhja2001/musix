import 'package:flutter/material.dart';
import 'package:musix/domain_music/models/models.dart';

import '../../../global/widgets/widgets.dart';

class VideoSelectionWidget extends StatelessWidget {
  final String title;
  final Video video;
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
            videoUrl: video.url,
            authorVideo: video.artistName,
            titleVideo: video.name,
          ),
        ))
      ],
    );
  }
}
