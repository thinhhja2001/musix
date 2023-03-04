import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:get_it/get_it.dart';
import 'package:musix/domain_song/utils/widget_util/text_scroll_widget.dart';
import 'package:musix/domain_song/views/widgets/control_widgets/repeat_button_widget.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../../theme/color.dart';
import '../../../../theme/text_style.dart';
import '../../../../utils/functions/function_utils.dart';
import '../../../entities/entities.dart';
import '../../../logic/song_bloc.dart';
import '../../../services/musix_audio_handler.dart';
import '../../../services/musix_lyric_ui.dart';
import '../../widgets.dart';
import '../../widgets/control_widgets/shuffle_button_widget.dart';
import '../../widgets/custom_slider.dart';

class LyricWidget extends StatelessWidget {
  const LyricWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      builder: (context, state) {
        final currentSong = state.songInfo;
        final currentSource = state.songSource;
        final musixAudioHandler = GetIt.instance.get<MusixAudioHandler>();
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
                currentSong?.thumbnailM ?? "",
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
                          currentSource?.lyricUrl != null
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
                            children: const [
                              ShuffleButtonWidget(),
                              SkipToPreviousButtonWidget(),
                              PlayButtonWidget(
                                width: 100,
                                height: 100,
                                iconSize: 50,
                              ),
                              SkipToNextButtonWidget(),
                              RepeatButtonWidget()
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
      },
    );
  }
}

class _SongInformationWidget extends StatelessWidget {
  const _SongInformationWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      builder: (context, state) {
        return Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    state.songInfo?.thumbnailM ?? "",
                  ),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultTextScrollWidget(
                      text: state.songInfo?.title ?? "",
                      textStyle: TextStyleTheme.ts22.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      state.songInfo?.artistsNames ?? "",
                      style: TextStyleTheme.ts18.copyWith(
                        color: ColorTheme.primary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
