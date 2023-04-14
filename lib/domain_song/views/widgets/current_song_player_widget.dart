import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/widget_util/text_scroll_widget.dart';
import 'control_widgets/shuffle_button_widget.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../theme/theme.dart';
import '../../../utils/functions/function_utils.dart';
import '../../entities/entities.dart';
import '../../logic/song_bloc.dart';
import '../screens.dart';
import '../widgets.dart';
import 'custom_slider.dart';

class CurrentSongPlayerWidget extends StatelessWidget {
  static const CurrentSongPlayerWidget _instance =
      CurrentSongPlayerWidget._internal();

  factory CurrentSongPlayerWidget() {
    return _instance;
  }

  const CurrentSongPlayerWidget._internal();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SongBloc, SongState, SongInfo?>(
      selector: (state) => state.songInfo,
      builder: (context, songInfo) {
        if (songInfo == null) return const SizedBox.shrink();
        final currentSong = songInfo;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) => const CurrentSongPlayerScreen(),
              isScrollControlled: true,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<PaletteGenerator>(
                    future:
                        updatePaletteGenerator(currentSong.thumbnailM ?? ""),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: snapshot.data!.dominantColor!.color,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(currentSong.thumbnailM ?? ""),
                            radius: 26,
                          ),
                        );
                      }
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: const [
                              BoxShadow(color: Colors.black, blurRadius: 10),
                            ]),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(currentSong.thumbnailM ?? ""),
                          radius: 26,
                        ),
                      );
                    }),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        defaultTextScrollWidget(
                          text: currentSong.title ?? "",
                          textStyle: TextStyleTheme.ts16.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          currentSong.artistsNames ?? "",
                          style: TextStyleTheme.ts12.copyWith(
                            color: ColorTheme.primary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const CustomSlider(
                          draggable: false,
                        ),
                      ],
                    ),
                  ),
                ),
                const ShuffleButtonWidget(),
                const SizedBox(
                  width: 8,
                ),
                const PlayButtonWidget(
                  width: 50,
                  height: 50,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
