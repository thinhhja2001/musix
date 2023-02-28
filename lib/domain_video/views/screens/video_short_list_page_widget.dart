import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain_global/views/home_screen/widgets/template_widget.dart';
import '../../models/models.dart';

import '../../entities/state/video_state.dart';
import '../../logic/video_bloc.dart';
import '../widgets/video_search_bar_widget.dart';
import '../widgets/video_short_list_widget.dart';

class VideoShortListPageWidget extends StatelessWidget {
  const VideoShortListPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        return HomeTemplateWidget(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              VideoSearchBarWidget(),
              const SizedBox(
                height: 20,
              ),
              VideoShortListWidget(
                title: "PMQ best",
                videos: sampleListVideoShorts,
              ),
              VideoShortListWidget(
                title: "PMQ best",
                videos: sampleListVideoShorts,
              ),
              VideoShortListWidget(
                title: "PMQ best",
                videos: sampleListVideoShorts,
              ),
              VideoShortListWidget(
                title: "PMQ best",
                videos: sampleListVideoShorts,
              ),
            ]),
          ),
        );
      },
    );
  }
}
