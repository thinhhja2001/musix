import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../models/models.dart';
import '../../services/musix_audio_handler.dart';
import '../screens.dart';
import 'custom_slider.dart';
import '../../../theme/theme.dart';
import '../../../utils/functions/function_utils.dart';
import 'package:palette_generator/palette_generator.dart';

class CurrentSongPlayerWidget extends StatelessWidget {
  const CurrentSongPlayerWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final MusixAudioHandler musixAudioHandler =
        GetIt.I.get<MusixAudioHandler>();
    final SongInfo song = musixAudioHandler.currentSong;

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
                future: updatePaletteGenerator(song.thumbnailM),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                              color: snapshot.data!.dominantColor!.color,
                              blurRadius: 10),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(song.thumbnailM),
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
                      backgroundImage: NetworkImage(song.thumbnailM),
                      radius: 26,
                    ),
                  );
                }),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Someone You Live",
                      style: TextStyleTheme.ts16.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Ariana Grande",
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
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shuffle,
                color: Colors.white,
              ),
            ),
            FloatingActionButton(
              backgroundColor: ColorTheme.primary,
              onPressed: () {},
              child: const Icon(Icons.play_arrow),
            )
          ],
        ),
      ),
    );
  }
}
