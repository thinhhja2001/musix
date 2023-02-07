import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musix/domain_music/models/models.dart';
import 'package:musix/utils/constant/color_constant.dart';
import 'package:musix/utils/constant/text_constant.dart';
import 'package:musix/utils/utils.dart';

class SongSelectionWidget extends StatelessWidget {
  const SongSelectionWidget({Key? key, required this.song}) : super(key: key);
  final Song song;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final player = AudioPlayer();
        player.setUrl(song.audioUrl);
        await player.play();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              '1',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: FontSizeConstant.kts18,
                color: ColorConstant.kWhite,
              ),
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
                  style: const TextStyle(
                      fontSize: FontSizeConstant.kts16,
                      color: ColorConstant.kPrimaryColor,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  song.artistName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: FontSizeConstant.kts14,
                    color: ColorConstant.kGrey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: ColorConstant.kPrimaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
