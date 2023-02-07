import 'package:flutter/material.dart';
import 'package:musix/domain_music/models/song.dart';
import 'package:musix/domain_music/views/widgets/song_selection_widget.dart';
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
                song: exampleSong,
              ),
              SongSelectionWidget(
                song: exampleSong,
              ),
              SongSelectionWidget(
                song: exampleSong,
              ),
              SongSelectionWidget(
                song: exampleSong,
              ),
              SongSelectionWidget(
                song: exampleSong,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
