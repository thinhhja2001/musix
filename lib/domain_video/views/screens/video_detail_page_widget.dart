import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_global/views/home_screen/widgets/widgets.dart';
import 'package:musix/domain_video/entities/event/video_event.dart';
import '../../../theme/theme.dart';
import '../../entities/state/video_state.dart';
import '../../logic/video_bloc.dart';
import '../widgets/video_player/video_detail_card_widget.dart';

class VideoDetailPageWidget extends StatelessWidget {
  const VideoDetailPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            context.read<VideoBloc>().add(
                  VideoBackEvent(),
                );
            return true;
          },
          child: HomeTemplateWidget(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const VideoDetailCardWidget(),
                Text(
                  state.videoDetail?.title ?? "",
                  style: TextStyleTheme.ts18.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  state.videoDetail?.artistsNames ?? "",
                  style: TextStyleTheme.ts16.copyWith(
                    color: ColorTheme.primary,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
