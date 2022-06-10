import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:musix/models/custom_lyric_ui.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/utils/constant.dart';
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
        future: updatePaletteGenerator(
            audioPlayerProvider.currentSong.thumbnailUrl),
        builder: (BuildContext context,
            AsyncSnapshot<PaletteGenerator> paletteData) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  paletteData.data != null
                      ? paletteData.data!.dominantColor!.color
                      : Colors.black,
                  Colors.black
                ])),
            child: Column(
              children: [
                audioPlayerProvider.lyric.isNotEmpty
                    ? LyricsReader(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        model: LyricsModelBuilder.create()
                            .bindLyricToMain(audioPlayerProvider.lyric)
                            .getModel(),
                        position: audioPlayerProvider.position.inMilliseconds,
                        lyricUi: lyricUI,
                        size: Size(double.infinity,
                            MediaQuery.of(context).size.height * 0.7),
                        emptyBuilder: () => Center(
                          child: Text(
                            "No lyrics",
                            style: lyricUI.getOtherMainTextStyle(),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: const Center(
                            child: Text(
                          'No lyric found',
                          style: kDefaultTitleStyle,
                        ))),
                const MusicSliderWidget(isSlidable: true),
                const DurationWidget(),
                const MusicControllerWidget(),
              ],
            ),
          );
        });
  }
}
