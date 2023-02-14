import 'package:flutter/material.dart';
import 'package:musix/domain_music/models/song.dart';
import 'package:musix/domain_music/views/widgets.dart';
import 'package:musix/global/widgets/rotated_text_widget.dart';

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
    return Row(
      children: [
        RotatedTextWidget(text: title),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SizedBox(
            height: songs.length * 56,
            child: ListView.builder(
              shrinkWrap: true,
              physics: isScrollable
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              itemCount: songs.length,
              itemBuilder: (context, index) => SongCardWidget(
                index: index + 1,
                isRequestIndex: isShowIndex,
                song: songs[index] ?? sampleSong,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
