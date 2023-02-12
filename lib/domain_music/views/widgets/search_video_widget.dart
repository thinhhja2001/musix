import 'package:flutter/material.dart';

import '../../../global/widgets/widgets.dart';
import '../../models/models.dart';
import '../widgets.dart';

class VideoListWidget extends StatelessWidget {
  final String title;
  final List<Video?> videos;
  final bool isShowIndex;
  const VideoListWidget({
    Key? key,
    required this.title,
    required this.videos,
    this.isShowIndex = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RotatedTextWidget(text: title),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SizedBox(
            height: videos.length * 56,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return VideosSelectionWidget(
                    video: videos[index] ?? sampleVideo,
                    index: index + 1,
                    isRequestIndex: isShowIndex,
                  );
                }),
          ),
        )
      ],
    );
  }
}
