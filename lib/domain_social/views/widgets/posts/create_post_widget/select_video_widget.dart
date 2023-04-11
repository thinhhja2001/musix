import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_social/entities/event/social_event.dart';
import 'package:musix/utils/functions/function_utils.dart';
import 'package:video_player/video_player.dart';

import '../../../../../theme/theme.dart';
import '../../../../entities/state/social_state.dart';
import '../../../../entities/utils/constant_utils.dart';
import '../../../../logic/social_bloc.dart';

class SelectVideoWidget extends StatefulWidget {
  const SelectVideoWidget({
    super.key,
  });

  @override
  State<SelectVideoWidget> createState() => _SelectVideoWidgetState();
}

class _SelectVideoWidgetState extends State<SelectVideoWidget> {
  FilePickerResult? fileResult;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        return InkWell(
          splashColor: ColorTheme.primary.withOpacity(.4),
          onTap: () async {
            await FilePicker.platform
                .pickFiles(
                  type: FileType.custom,
                  allowedExtensions: getAudioSupportedFormat(),
                )
                .then(
                  (result) => {
                    if (result != null)
                      {
                        context.read<SocialBloc>().add(
                            SocialAddPostDataSourceEvent(
                                File(result.files.first.path!)))
                      }
                  },
                );
          },
          child: state.sourceData == null
              ? const _SelectVideoWidget()
              : FutureBuilder<ChewieController>(
                  future: createChewieController(state.sourceData!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AspectRatio(
                          aspectRatio: snapshot
                              .data!.videoPlayerController.value.aspectRatio,
                          child: Chewie(
                            controller: snapshot.data!,
                          ),
                        ),
                      );
                    }
                    return shimmerLoadingEffect(width: double.infinity);
                  }),
        );
      },
    );
  }
}

Future<ChewieController> createChewieController(File file) async {
  VideoPlayerController videoPlayerController =
      VideoPlayerController.file(file);
  await videoPlayerController.initialize();
  return ChewieController(
      videoPlayerController: videoPlayerController,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: ColorTheme.primary,
        bufferedColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
      allowFullScreen: true);
}

class _SelectVideoWidget extends StatelessWidget {
  const _SelectVideoWidget();

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: ColorTheme.primary,
      radius: const Radius.circular(10),
      borderType: BorderType.RRect,
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.movie_rounded,
            size: 50,
            color: Colors.white,
          ),
          Text(
            "Upload your video",
            style: TextStyleTheme.ts18.copyWith(color: Colors.white),
          ),
        ]),
      ),
    );
  }
}
