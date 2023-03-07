import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter/bloc_exporter.dart';
import 'package:musix/config/exporter/state_exporter.dart';
import '../../../domain_global/views/home_screen/widgets.dart';
import '../../../routing/routing_path.dart';
import '../../models/models.dart';

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
              SearchBarNavigationWidget(
                hintText: r'What do you want to hear?',
                onTap: () {
                  context
                      .read<SearchMusicBloc>()
                      .add(SearchMusicChangeToVideoEvent());
                  Navigator.of(context).pushNamed(RoutingPath.searchVideo);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              VideoShortListWidget(
                videoShortListType: VideoShortListType.carousel,
                title: "PMQ best",
                videos: sampleListVideoShorts,
              ),
              VideoShortListWidget(
                videoShortListType: VideoShortListType.carousel,
                title: "PMQ best",
                videos: sampleListVideoShorts,
              ),
              VideoShortListWidget(
                videoShortListType: VideoShortListType.carousel,
                title: "PMQ best",
                videos: sampleListVideoShorts,
              ),
              VideoShortListWidget(
                videoShortListType: VideoShortListType.carousel,
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
