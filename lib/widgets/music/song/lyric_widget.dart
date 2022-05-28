import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:musix/models/custom_lyric_ui.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/utils.dart';
import 'package:musix/widgets/music/song/duration_widget.dart';
import 'package:musix/widgets/music/song/music_controller_widget.dart';
import 'package:musix/widgets/music/song/music_slider_widget.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class LyricsWidget extends StatelessWidget {
  const LyricsWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    var lyricUI = CustomLyricUI();
    return FutureBuilder(
        future: getLyricFromLrcLink(audioPlayerProvider.currentSong.lyricUrl),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<PaletteGenerator>(
              future: updatePaletteGenerator(
                  audioPlayerProvider.currentSong.thumbnailUrl),
              builder:
                  (BuildContext context, AsyncSnapshot<dynamic> palletteData) {
                if (palletteData.hasData) {
                  return Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          palletteData.data!.dominantColor!.color,
                          Colors.black
                        ])),
                    child: Column(
                      children: [
                        LyricsReader(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          model: LyricsModelBuilder.create()
                              .bindLyricToMain(snapshot.data)
                              .getModel(),
                          position: audioPlayerProvider.position.inMilliseconds,
                          lyricUi: lyricUI,
                          size: Size(double.infinity,
                              MediaQuery.of(context).size.height * 0.7),
                          playing: audioPlayerProvider.isPlaying,
                          emptyBuilder: () => Center(
                            child: Text(
                              "No lyrics",
                              style: lyricUI.getOtherMainTextStyle(),
                            ),
                          ),
                        ),
                        const MusicSliderWidget(isSlidable: true),
                        const DurationWidget(),
                        const MusicControllerWidget()
                      ],
                    ),
                  );
                }
                return Container(
                  color: kBackgroundColor,
                  child: const Center(
                    child: CircularProgressIndicator(color: kPrimaryColor),
                  ),
                );
              },
            );
          }
          return Container(
            color: kBackgroundColor,
            child: const Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            ),
          );
        });
  }
}
