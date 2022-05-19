import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import 'lyric_widget.dart';
import 'main_music_player_widget.dart';

class MusicPlayerWidget extends StatelessWidget {
  const MusicPlayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
        loop: false,
        itemCount: 2,
        itemBuilder: (context, index) {
          return index == 0
              ? const MainMusicPlayerWidget()
              : const LyricsWidget();
        });
  }
}
