import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:musix/domain_music/services/musix_audio_handler.dart';
import 'package:musix/domain_music/views/screens/lyric_screen.dart';
import 'package:musix/domain_music/views/widgets.dart';
import 'package:musix/domain_music/views/widgets/custom_slider.dart';
import 'package:musix/theme/color.dart';
import 'package:musix/theme/text_style.dart';
import 'package:musix/utils/functions/function_utils.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../models/models.dart';
import '../widgets/control_widgets/repeat_button_widget.dart';

class CurrentSongPlayerScreen extends StatelessWidget {
  const CurrentSongPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: const [
        _CurrentSongPlayerWidget(),
        LyricScreen(),
      ],
      options: CarouselOptions(
        height: double.infinity,
        enableInfiniteScroll: false,
        viewportFraction: 1,
      ),
    );
  }
}

class _CurrentSongPlayerWidget extends StatelessWidget {
  const _CurrentSongPlayerWidget();

  @override
  Widget build(BuildContext context) {
    final MusixAudioHandler musixAudioHandler =
        GetIt.I.get<MusixAudioHandler>();
    final Song song = musixAudioHandler.currentSong;
    return FutureBuilder<PaletteGenerator>(
        future: updatePaletteGenerator(
          song.thumbnailUrl,
        ),
        builder: (context, snapshot) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  snapshot.hasData
                      ? snapshot.data!.dominantColor!.color
                      : Colors.black,
                  Colors.black,
                ],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const _CloseButtonWidget(),
                  CircleAvatar(
                    radius: 120,
                    backgroundImage: NetworkImage(
                      song.thumbnailUrl,
                    ),
                  ),
                  _SongInformationWidget(song: song),
                  // Music control field (Add to favorites, Add to playlists, ...)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.share_outlined,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.playlist_add,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.file_download_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const CustomSlider(draggable: true),
                  // Audio player control field
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
                      const RepeatButtonWidget(),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class _CloseButtonWidget extends StatelessWidget {
  const _CloseButtonWidget();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.expand_more,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

class _SongInformationWidget extends StatelessWidget {
  const _SongInformationWidget({
    required this.song,
  });

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          song.name,
          style: TextStyleTheme.ts28.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          song.artistName,
          style: TextStyleTheme.ts16.copyWith(
            color: ColorTheme.primary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
