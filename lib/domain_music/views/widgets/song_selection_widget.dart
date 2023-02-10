import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musix/domain_music/models/models.dart';
import 'package:musix/theme/theme.dart';

class SongSelectionWidget extends StatelessWidget {
  const SongSelectionWidget({
    Key? key,
    required this.song,
    required this.index,
    this.padding = 16,
  }) : super(key: key);

  final Song song;
  final int index;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding, right: padding),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: ColorTheme.primaryLighten.withOpacity(0.3),
        onTap: () async {
          final player = AudioPlayer();
          player.setUrl(song.audioUrl);
          await player.play();
        },
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  '#$index',
                  style: TextStyleTheme.ts16.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 26 - (index.toString().length - 1) * 10,
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    3,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      song.thumbnailUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      song.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleTheme.ts14.copyWith(
                        color: ColorTheme.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      song.artistName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleTheme.ts12.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorTheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.8,
                      color: ColorTheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  width: 24,
                  height: 24,
                  child: const Center(
                    child: Icon(
                      Icons.more_horiz,
                      color: ColorTheme.primary,
                      size: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
