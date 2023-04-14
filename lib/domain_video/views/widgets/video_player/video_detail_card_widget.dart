import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../theme/theme.dart';
import '../../../entities/state/video_state.dart';
import '../../../logic/video_bloc.dart';
import 'video_player_widget.dart';

class VideoDetailCardWidget extends StatelessWidget {
  const VideoDetailCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        return state.chewieController != null
            ? VideoPlayerWidget(
                controller: state.chewieController!,
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: ColorTheme.primary,
                ),
              );
      },
    );
  }
}
