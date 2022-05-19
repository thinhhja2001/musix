import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/utils.dart';
import 'package:musix/widgets/music/music_slider_widget.dart';
import 'package:provider/provider.dart';

import 'duration_widget.dart';
import 'music_controller_widget.dart';

class MusicPlayerWidget extends StatelessWidget {
  const MusicPlayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.black),
      child: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.055),
              child: const Align(
                alignment: Alignment.topLeft,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            CircleAvatar(
              backgroundImage:
                  NetworkImage(audioPlayerProvider.currentSong.thumbnailUrl),
              radius: 100,
            ),
            verticalSpaceRegular,
            Text(
              audioPlayerProvider.currentSong.name,
              style: kDefaultTextStyle,
            ),
            verticalSpaceRegular,
            Text(
              audioPlayerProvider.currentSong.artistName,
              style: kDefaultTextStyle.copyWith(color: kPrimaryColor),
            ),
            const Text(
              'It is a long established fat that a reader',
              style: kDefaultTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/images/share.svg')),
                IconButton(
                    onPressed: () {},
                    icon:
                        SvgPicture.asset('assets/images/add_to_playlist.svg')),
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/images/download.svg')),
              ],
            ),
            const MusicSliderWidget(isSlidable: true),
            const DurationWidget(),
            const MusicControllerWidget()
          ],
        ),
      ),
    );
  }
}
