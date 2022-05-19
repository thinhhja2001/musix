import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/utils/utils.dart';
import 'package:musix/widgets/music/music_player_widget.dart';
import 'package:musix/widgets/music/play_music_button.dart';
import 'package:musix/widgets/music/music_slider_widget.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../forget_password_widget.dart';

class CurrentMusicPlayer extends StatelessWidget {
  const CurrentMusicPlayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: GestureDetector(
        onTap: (() => showModalBottomSheet(
              context: context,
              builder: (context) => const MusicPlayerWidget(),
              isScrollControlled: true,
            )),
        child: Row(
          children: [
            FutureBuilder<PaletteGenerator>(
                future: updatePaletteGenerator(
                    audioPlayerProvider.currentSong.thumbnailUrl),
                builder: (context, snapshot) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                              color: snapshot.data!.dominantColor!.color,
                              blurRadius: 10),
                        ]),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          audioPlayerProvider.currentSong.thumbnailUrl),
                      radius: 26,
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: defaultTextScrollWidget(
                          audioPlayerProvider.currentSong.name)),
                  Text(
                    audioPlayerProvider.currentSong.artistName,
                    style: kDefaultTextStyle.copyWith(
                        color: kPrimaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    transform: Matrix4.translationValues(-20, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const MusicSliderWidget(isSlidable: false),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(
                              FontAwesomeIcons.shuffle,
                              color: Colors.white,
                              size: 20,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: PlayMusicButton(
                                    buttonSize: 36, iconSize: 24))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
