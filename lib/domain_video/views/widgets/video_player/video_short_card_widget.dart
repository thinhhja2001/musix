import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter/bloc_exporter.dart';
import 'package:musix/config/exporter/state_exporter.dart';
import 'package:musix/domain_artist/entities/artist/artist.dart';
import 'package:musix/domain_video/views/screens/video_detail_page_widget.dart';
import 'package:musix/routing/routing_path.dart';
import 'package:musix/utils/functions/function_utils.dart';

import '../../../../theme/theme.dart';
import '../../../entities/event/video_event.dart';
import '../../../entities/state/video_state.dart';
import '../../../entities/video_short.dart';
import '../../../logic/video_bloc.dart';
// ignore: implementation_imports

class VideoShortCardWidget extends StatelessWidget {
  const VideoShortCardWidget({
    super.key,
    required this.videoShort,
    this.isCreateNewSheet = true,
  });
  final VideoShort videoShort;

  /// Whether to create a new modalBottomSheet or just replace current
  final bool isCreateNewSheet;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(builder: (context, state) {
      return InkWell(
        onTap: () async {
          context.read<VideoBloc>().add(
                VideoGetVideoDetailEvent(videoShort.encodeID ?? ""),
              );
          isCreateNewSheet
              ? showModalBottomSheet(
                  context: context,
                  builder: (context) => const VideoDetailPageWidget(),
                  isScrollControlled: true,
                  backgroundColor: ColorTheme.background,
                ).then(
                  // On Close Event Modal Bottom Sheet
                  (value) => context.read<VideoBloc>().add(
                        VideoBackEvent(),
                      ),
                )
              : null;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(videoShort.thumbnailM ?? ""),
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        formatTime(timeInSecond: videoShort.duration ?? 0),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _VideoInformationWidget(videoShort: videoShort),
          ],
        ),
      );
    });
  }
}

class _VideoInformationWidget extends StatelessWidget {
  const _VideoInformationWidget({
    required this.videoShort,
  });

  final VideoShort videoShort;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          InkWell(
            onTap: () => {
              context.read<ArtistBloc>().add(
                    ArtistGetInfoEvent(videoShort.artists!.first.alias!),
                  ),
              Navigator.pushNamed(
                context,
                RoutingPath.artistInfo,
              )
            },
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage(videoShort.artists?.first.thumbnailM ?? ""),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoShort.title ?? "",
                    style: TextStyleTheme.ts18.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    videoShort.artistsNames ?? "",
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
        ],
      ),
    );
  }
}
