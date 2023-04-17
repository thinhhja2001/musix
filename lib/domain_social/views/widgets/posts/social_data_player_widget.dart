import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import '../../../../domain_video/views/widgets/center_play_pause_button.dart';
import 'package:video_player/video_player.dart';

import '../../../../theme/theme.dart';
import '../../../utils/custom_social_media_control.dart';

class SocialDataPlayerWidget extends StatefulWidget {
  const SocialDataPlayerWidget({
    Key? key,
    required this.dataUrl,
    required this.title,
    required this.artistName,
    required this.thumbnailUrl,
  }) : super(key: key);
  final String dataUrl;
  final String thumbnailUrl;
  final String title;
  final String artistName;
  @override
  State<SocialDataPlayerWidget> createState() => _SocialDataPlayerWidgetState();
}

class _SocialDataPlayerWidgetState extends State<SocialDataPlayerWidget> {
  late ChewieController chewieController;
  bool isStartPlayingVideo = false;

  final barHeight = 48.0 * 1.5;

  Widget buildVideoPlayer() => Chewie(controller: chewieController);

  @override
  Widget build(BuildContext context) {
    if (!isStartPlayingVideo) {
      return _buildThumbnail();
    }
    return chewieController.videoPlayerController.value.isInitialized
        ? Container(color: Colors.black, child: buildVideoPlayer())
        : const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(
                color: ColorTheme.primary,
              ),
            ),
          );
  }

  Container _buildThumbnail() {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.thumbnailUrl), fit: BoxFit.fill),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style:
                              TextStyleTheme.ts18.copyWith(color: Colors.black),
                        ),
                        Text(
                          widget.artistName,
                          style: TextStyleTheme.ts16.copyWith(
                            color: ColorTheme.primary,
                          ),
                        ),
                      ]),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: CenterPlayButton(
                      backgroundColor: Colors.black54,
                      iconColor: Colors.white,
                      onPressed: () async {
                        chewieController = await buildChewieController(
                            dataUrl: widget.dataUrl,
                            title: widget.title,
                            artistName: widget.artistName);
                        setState(() {
                          isStartPlayingVideo = true;
                        });
                      },
                      show: true,
                      isPlaying: false,
                      isFinished: false))
            ],
          ),
        ));
  }
}

Future<ChewieController> buildChewieController(
    {required String dataUrl,
    required String title,
    required String artistName}) async {
  VideoPlayerController videoPlayerController =
      VideoPlayerController.network(dataUrl);
  await videoPlayerController.initialize();
  return ChewieController(
      videoPlayerController: videoPlayerController,
      showControls: true,
      customControls: CustomSocialMediaControl(
        title: title,
        singer: artistName,
      ),
      materialProgressColors: ChewieProgressColors(
        playedColor: ColorTheme.primary,
        bufferedColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
      allowFullScreen: true);
}
