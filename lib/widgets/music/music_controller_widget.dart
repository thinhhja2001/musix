import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musix/widgets/music/play_music_button.dart';

class MusicControllerWidget extends StatelessWidget {
  const MusicControllerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/images/shuffle.svg'),
          color: Colors.white,
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/images/previous.svg'),
          color: Colors.white,
        ),
        const PlayMusicButton(
          buttonSize: 75,
          iconSize: 40,
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/images/next.svg'),
          color: Colors.white,
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/images/loop.svg'),
          color: Colors.white,
        ),
      ],
    );
  }
}
