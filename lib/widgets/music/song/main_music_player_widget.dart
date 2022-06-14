import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/utils/utils.dart';
import 'package:musix/widgets/music/button/add_song_to_playlist_icon_button.dart';
import 'package:musix/widgets/music/button/timer_icon_button.dart';
import 'package:musix/widgets/music/button/favorite_icon_button.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import 'duration_widget.dart';
import 'music_controller_widget.dart';
import 'music_slider_widget.dart';

class MainMusicPlayerWidget extends StatelessWidget {
  const MainMusicPlayerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    return FutureBuilder<PaletteGenerator>(
      future:
          updatePaletteGenerator(audioPlayerProvider.currentSong.thumbnailUrl),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  snapshot.data!.dominantColor!.color,
                  Colors.black
                ])),
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.055),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              audioPlayerProvider.currentSong.thumbnailUrl),
                          radius: 100,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: defaultTextScrollWidget(
                            text: audioPlayerProvider.currentSong.name,
                            textStyle: kDefaultTextStyle,
                          ),
                        ),
                        Text(
                          audioPlayerProvider.currentSong.artistName,
                          style:
                              kDefaultTextStyle.copyWith(color: kPrimaryColor),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                    'assets/images/share.svg')),
                            AddSongToPlaylistIconButton(
                              song: audioPlayerProvider.currentSong,
                            ),
                            const FavoriteIconButton(),
                            const TimerIconButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const MusicSliderWidget(isSlidable: true),
                  const DurationWidget(),
                  const MusicControllerWidget(),
                  verticalSpaceLarge
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
