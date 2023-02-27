import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:musix/domain_video/entities/event/video_event.dart';
import 'package:musix/domain_video/views/widgets/video_player/video_short_card_widget.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.videoDetail != null
                ? _detailWidget(state)
                : [
                    const Expanded(
                        child: Center(
                      child: CircularProgressIndicator(
                        color: ColorTheme.primary,
                      ),
                    ))
                  ],
          ),
        );
      },
    );
  }

  List<Widget> _detailWidget(VideoState state) {
    return [
      const SizedBox(
        height: 20,
      ),
      const VideoDetailCardWidget(),
      const _VideoInformationWidget(),
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
                    padding: const EdgeInsets.only(top: 8.0),
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
    ];
  }
}

class _VideoInformationWidget extends StatelessWidget {
  const _VideoInformationWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    state.videoDetail?.artists?.first.thumbnailM ?? ""),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  top: 8.0,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.videoDetail?.title ?? "",
                        style: TextStyleTheme.ts18.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          overflow: TextOverflow.visible,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        state.videoDetail?.artistsNames ?? "",
                        style: TextStyleTheme.ts16.copyWith(
                          fontWeight: FontWeight.w400,
                          color: ColorTheme.primary,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Text(
                DateFormat("dd MMM, yyyy").format(
                  state.videoDetail?.createdAt ?? DateTime.now(),
                ),
                style: TextStyleTheme.ts16.copyWith(
                  fontWeight: FontWeight.w400,
                  color: ColorTheme.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
