import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../repository/song_source_repository.dart';
import '../../models/songs/song_info.dart';
import '../../services/musix_audio_handler.dart';
import '../widgets.dart';
import '../../../global/widgets/rotated_text_widget.dart';

class SongListWidget extends StatelessWidget {
  final String title;
  final List<SongInfo?> songs;
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
                  (index) => SongCardWidget(
                    index: index + 1,
                    isRequestIndex: isShowIndex,
                    song: songs[index] ?? sampleSong,
                    onPress: () async {
                      final songSource = await SongSourceRepositoryImpl()
                          .getInfo(songs[index]!.encodeId);
                      musixAudioHandler.setSong(songs[index]!, songSource);
                      musixAudioHandler.play();
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
