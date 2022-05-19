import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/utils/utils.dart';
import 'package:musix/widgets/music/duration_widget.dart';
import 'package:musix/widgets/music/music_controller_widget.dart';
import 'package:musix/widgets/music/music_slider_widget.dart';
import 'package:provider/provider.dart';

class LyricsWidget extends StatelessWidget {
  const LyricsWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    var lyricUI = UINetease();
    return FutureBuilder(
        future: getLyricFromLrcLink(audioPlayerProvider.currentSong.lyricUrl),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: const BoxDecoration(color: Colors.black),
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
          return Container();
        });
  }
}
