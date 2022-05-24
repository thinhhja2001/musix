import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/widgets/music/button/add_song_to_playlist_icon_button.dart';
import 'package:musix/widgets/music/button/download_icon_button.dart';
import 'package:musix/widgets/music/button/favorite_icon_button.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import '../../providers/audio_player_provider.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../utils/utils.dart';
import 'album/all_album_of_current_user.dart';
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
                    backgroundImage: NetworkImage(
                        audioPlayerProvider.currentSong.thumbnailUrl),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset('assets/images/share.svg')),
                      const AddSongToPlaylistIconButton(),
                      const FavoriteIconButton(),
                      const DownloadIconButton(),
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
        return Container();
      },
    );
  }
}
