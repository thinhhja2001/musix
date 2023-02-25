import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_global/views/home_screen/widgets/template_widget.dart';
import 'package:musix/domain_video/models/models.dart';
import 'package:musix/domain_video/utils/convert_video.dart';
import 'package:musix/domain_video/views/widgets/video_player/video_detail_card_widget.dart';
import 'package:musix/domain_video/views/widgets/video_player/video_short_card_widget.dart';

import '../../entities/state/video_state.dart';
import '../../logic/video_bloc.dart';

class VideoShortListPageWidget extends StatelessWidget {
  const VideoShortListPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        return HomeTemplateWidget(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: sampleListVideoShorts
                  .map((videoShort) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: VideoShortCardWidget(
                            videoShort: convertVideoShortModel(videoShort)),
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
