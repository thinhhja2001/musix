import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routing/routing_path.dart';
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
  });
  final VideoShort videoShort;
  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoBloc, VideoState>(
      listener: (context, state) {
        if (state.isVideoLoaded == true) {
          Navigator.pushNamed(context, RoutingPath.videoDetailPage);
        }
      },
      child: InkWell(
        onTap: () async {
          context.read<VideoBloc>().add(
                VideoGetVideoDetailEvent(videoShort.encodeID ?? ""),
              );
        },
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.8,
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(videoShort.thumbnailM ?? ""),
                  ),
                  borderRadius: BorderRadius.circular(10)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoShort.title ?? "",
                    style: TextStyleTheme.ts18.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
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
          ],
        ),
      ),
    );
  }
}
