import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:musix/domain_video/entities/event/video_event.dart';
import 'package:musix/domain_video/views/widgets/video_player/video_short_card_widget.dart';
import 'package:musix/routing/routing_path.dart';
import 'package:shimmer/shimmer.dart';
import '../../../config/exporter/bloc_exporter.dart';
import '../../../config/exporter/state_exporter.dart';
import '../../../theme/theme.dart';
import '../../entities/state/video_state.dart';
import '../../logic/video_bloc.dart';
import '../widgets/next_video_list_widget.dart';
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
      const NextVideoListWidget()
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
              InkWell(
                onTap: () => {
                  context.read<ArtistBloc>().add(
                        ArtistGetInfoEvent(
                            state.videoDetail!.artists!.first.alias!),
                      ),
                  Navigator.pushNamed(
                    context,
                    RoutingPath.artistInfo,
                  )
                },
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          state.videoDetail?.artists?.first.thumbnailM ?? "",
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: ColorTheme.background,
                        highlightColor: ColorTheme.backgroundDarker,
                        child: const Material(
                          color: Colors.white,
                          child: SizedBox(
                            width: double.infinity,
                            height: 240,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
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
