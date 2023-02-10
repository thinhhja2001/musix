import 'package:flutter/material.dart';
import 'package:musix/domain_music/models/song.dart';
import 'package:musix/domain_music/views/widgets.dart';
import 'package:musix/global/widgets/rotated_text_widget.dart';

class RecentlySongWidget extends StatelessWidget {
  const RecentlySongWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const RotatedTextWidget(text: "Recently Music"),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            children: [
              SongSelectionWidget(
                index: 1,
                song: sampleSong,
              ),
              SongSelectionWidget(
                index: 1,
                song: sampleSong,
              ),
              SongSelectionWidget(
                index: 1,
                song: sampleSong,
              ),
              SongSelectionWidget(
                index: 1,
                song: sampleSong,
              ),
              SongSelectionWidget(
                index: 20,
                song: sampleSong,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
