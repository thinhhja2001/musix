import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../theme/theme.dart';
import '../../../utils/functions/function_utils.dart';
import '../../entities/entities.dart';
import '../../logic/song_bloc.dart';
import '../../utils/widget_util/text_scroll_widget.dart';
import '../screens.dart';
import '../widgets.dart';
import 'control_widgets/shuffle_button_widget.dart';
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
        return Dismissible(
          key: const ValueKey('Audio Player'),
          direction: DismissDirection.down,
          onDismissed: (_) {
            Feedback.forLongPress(context);
            context.read<SongBloc>().add(
                  SongPauseEvent(),
                );
            context.read<SongBloc>().add(
                  SongResetEvent(),
                );
          },
          child: Dismissible(
            key: ValueKey(songInfo.encodeId!),
            confirmDismiss: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                context.read<SongBloc>().add(
                      SongPlayPreviousSongEvent(),
                    );
              } else {
                context.read<SongBloc>().add(
                      SongPlayNextSongEvent(),
                    );
              }
              return Future.value(false);
            },
            child: SizedBox(
              height: 132,
              child: Stack(
                children: [
                  FutureBuilder<PaletteGenerator>(
                      future:
                          updatePaletteGenerator(currentSong.thumbnailM ?? ""),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Material(
                              color: snapshot.data!.dominantColor!.color,
                              child: const SizedBox.expand(),
                            ),
                          );
                          // return Container(
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(50),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: snapshot.data!.dominantColor!.color,
                          //         blurRadius: 10,
                          //       ),
                          //     ],
                          //   ),
                          // );
                        }
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: const Material(
                            color: Colors.black,
                            child: SizedBox.expand(),
                          ),
                        );
                      }),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: GestureDetector(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => const CurrentSongPlayerScreen(),
                        isScrollControlled: true,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(currentSong.thumbnailM ?? ""),
                                radius: 30,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                          const CustomSlider(
                            draggable: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
