import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:musix/domain_music/services/musix_audio_handler.dart';
import 'package:musix/domain_music/views/widgets.dart';
import 'package:musix/global/widgets/rotated_text_widget.dart';

import '../../entities/song.dart';

class SongListWidget extends StatelessWidget {
  final String title;
  final List<Song?> songs;
  final bool isShowIndex;
  final bool isScrollable;

  const SongListWidget({
    Key? key,
    required this.title,
    required this.songs,
    this.isShowIndex = true,
    this.isScrollable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MusixAudioHandler musixAudioHandler =
        GetIt.I.get<MusixAudioHandler>();
    return Row(
      children: [
        RotatedTextWidget(text: title),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: isScrollable
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(
                  songs.length,
                  (index) => songs[index] == null
                      ? const SizedBox.shrink()
                      : SongCardWidget(
                          index: index + 1,
                          isRequestIndex: isShowIndex,
                          song: songs[index]!,
                          onPress: () => {
                            // musixAudioHandler.setSong(songs[index]!),
                            // musixAudioHandler.play(),
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
