import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:get_it/get_it.dart';
import 'package:musix/domain_music/services/musix_audio_handler.dart';
import 'package:musix/domain_music/services/musix_lyric_ui.dart';
import 'package:musix/domain_music/views/widgets/custom_slider.dart';
import 'package:musix/theme/color.dart';
import 'package:musix/theme/text_style.dart';
import 'package:musix/utils/functions/function_utils.dart';
import 'package:palette_generator/palette_generator.dart';

import '../widgets.dart';

class LyricScreen extends StatelessWidget {
  const LyricScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final musixAudioHandler = GetIt.I.get<MusixAudioHandler>();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.green,
            Colors.black,
          ],
        ),
      ),
      child: FutureBuilder<PaletteGenerator>(
          future: updatePaletteGenerator(
            musixAudioHandler.currentSong.thumbnailUrl,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      snapshot.data!.dominantColor!.color,
                      Colors.black,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
                        child: _SongInformationWidget(),
                      ),
                      musixAudioHandler.lyric.isNotEmpty
                          ? LyricsReader(
                              position: musixAudioHandler
                                  .player.position.inMilliseconds,
                              model: LyricsModelBuilder.create()
                                  .bindLyricToMain(musixAudioHandler.lyric)
                                  .getModel(),
                              size: Size(
                                double.infinity,
                                MediaQuery.of(context).size.height * 0.6,
                              ),
                              lyricUi: MusixLyricUI(),
                              emptyBuilder: () => const Center(
                                child: Text("No lyric found"),
                              ),
                            )
                          : Center(
                              child: Text(
                                "No lyric found",
                                style: TextStyleTheme.ts16
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                      const Spacer(),
                      const CustomSlider(draggable: true),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.shuffle,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          const SkipToPreviousButtonWidget(),
                          const PlayButtonWidget(width: 100, height: 100),
                          const SkipToNextButtonWidget(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.loop_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              );
            }
            return Container();
          }),
    );
  }
}

class _SongInformationWidget extends StatelessWidget {
  const _SongInformationWidget();

  @override
  Widget build(BuildContext context) {
    final MusixAudioHandler musixAudioHandler =
        GetIt.I.get<MusixAudioHandler>();
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                musixAudioHandler.currentSong.thumbnailUrl,
              ),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                musixAudioHandler.currentSong.name,
                style: TextStyleTheme.ts22.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                musixAudioHandler.currentSong.artistName,
                style: TextStyleTheme.ts12.copyWith(
                  color: ColorTheme.primary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
