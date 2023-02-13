import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:musix/domain_music/models/models.dart';
import 'package:musix/domain_music/services/musix_audio_hander.dart';
import 'package:musix/theme/theme.dart';

import 'package:musix/utils/utils.dart';
import 'package:zingmp3_api/zingmp3_api.dart';

class SongSelectionWidget extends StatelessWidget {
  const SongSelectionWidget({Key? key, required this.song}) : super(key: key);
  final Song song;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final player = GetIt.I.get<MusixAudioHandler>();
        final songFrom = await ZingMP3API.getSongDataByKey("ZW78BW9D");
        print("song data is $songFrom");
        player.setSong(song);
        await player.play();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              '1',
              style: TextStyleTheme.ts18.copyWith(fontWeight: FontWeight.w300),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: DistinctConstant.small,
            ),
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
                  fit: BoxFit.cover),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: DistinctConstant.small,
            ),
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
                  style: TextStyleTheme.ts16.copyWith(
                    color: ColorTheme.primary,
                    fontWeight: FontWeight.w300,
                  ),
                  // style: const TextStyle(
                  //     fontSize: FontSizeConstant.kts16,
                  //     color: ColorConstant.kPrimaryColor,
                  //     fontWeight: FontWeight.w300),
                ),
                Text(
                  song.artistName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleTheme.ts14.copyWith(
                    fontWeight: FontWeight.w300,
                    color: ColorTheme.grey,
                  ),
                  // style: const TextStyle(
                  //   fontSize: FontSizeConstant.kts14,
                  //   color: ColorConstant.kGrey,
                  //   fontWeight: FontWeight.w300,
                  // ),
                ),
              ],
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: ColorTheme.primary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
