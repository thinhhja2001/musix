import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../config/exporter.dart';
import '../../../global/widgets/widgets.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';
import '../current_song_player_screen/current_song_player_screen.dart';
import '../widgets.dart';

class SongsInfoScreen extends StatelessWidget {
  const SongsInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      persistentFooterButtons: [CurrentSongPlayerWidget()],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: BlocSelector<SongsBloc, SongsState, String>(
          selector: (state) => state.title ?? "",
          builder: (context, title) {
            return Text(title);
          },
        ),
        titleTextStyle: TextStyleTheme.ts22
            .copyWith(color: Colors.white, fontWeight: FontWeight.w300),
        leading: IconButton(
          onPressed: () {
            context.read<SongsBloc>().add(const BackSongsEvent());
            Navigator.maybePop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      body: BlocBuilder<SongsBloc, SongsState>(
        builder: (context, state) {
          if (state.status?[SongsStatusKey.global.name] == Status.loading) {
            return const Center(
                child: SpinKitPulse(
              color: ColorTheme.primary,
              size: 100,
            ));
          } else {
            var songs = state.songs;
            if (songs == null || songs.isEmpty == true) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.sentiment_dissatisfied_outlined,
                      size: 24,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      r"There's no songs here",
                      style: TextStyleTheme.ts15.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...List.generate(
                    songs.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomCardInfoWidget(
                          index: index,
                          image: songs[index].thumbnailM,
                          title: songs[index].title!,
                          subTitle: songs[index].artistsNames,
                          padding: 0,
                          onCardPress: () {
                            context
                                .read<SongBloc>()
                                .add(SongSetListSongInfoEvent(
                                  songs,
                                ));
                            context.read<SongBloc>().add(
                                SongStartPlayingSectionEvent(
                                    songs.elementAt(index)));
                            showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  const CurrentSongPlayerScreen(),
                              isScrollControlled: true,
                            );
                          },
                          isShowAdditionButton: false,
                          additionWidget: IconButton(
                            onPressed: () {
                              context
                                  .read<SongsBloc>()
                                  .add(RemoveSongEvent(songs[index].encodeId!));
                              context
                                  .read<UserMusicBloc>()
                                  .add(FavoriteSongEvent(
                                    id: songs[index].encodeId!,
                                    title: songs[index].title!,
                                    artistNames: songs[index].artistsNames!,
                                    genreNames: songs[index].genreNames,
                                  ));
                            },
                            icon: Icon(
                              state.title!.contains("Favorite")
                                  ? Icons.favorite
                                  : Icons.do_disturb_on,
                              color: Colors.redAccent,
                              size: 24,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
