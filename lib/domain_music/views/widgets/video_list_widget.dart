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
          child: SingleChildScrollView(
            physics: isScrollable
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(
                  videos.length,
                  (index) => VideoCardWidget(
                    index: index + 1,
                    isRequestIndex: isShowIndex,
                    video: videos[index] ?? sampleVideo,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
