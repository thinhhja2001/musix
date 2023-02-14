import 'package:flutter/material.dart';

import '../../../global/widgets/widgets.dart';
import '../../models/models.dart';
import '../widgets.dart';

class VideoListWidget extends StatelessWidget {
  final String title;
  final List<Video?> videos;
  final bool isShowIndex;
  final bool isScrollable;

  const VideoListWidget({
    Key? key,
    required this.title,
    required this.videos,
    this.isShowIndex = false,
    this.isScrollable = false,
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
            height: videos.length * 120,
            child: ListView.builder(
                shrinkWrap: true,
                physics: isScrollable
                    ? const BouncingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return VideoCardWidget(
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
