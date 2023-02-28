import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/theme.dart';
import '../../entities/state/video_state.dart';
import '../../logic/video_bloc.dart';
import 'video_player/video_short_card_widget.dart';

class NextVideoListWidget extends StatelessWidget {
  const NextVideoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Next Video",
                  style: TextStyleTheme.ts22.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (state.videoDetail == null)
                Container()
              else
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...state.videoDetail!.recommends!.map(
                          (recommend) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: VideoShortCardWidget(
                              videoShort: recommend,
                              isCreateNewSheet: false,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
