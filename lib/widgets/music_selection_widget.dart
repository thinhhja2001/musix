import 'package:flutter/material.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/constant.dart';

class MusicSelectionWidget extends StatelessWidget {
  const MusicSelectionWidget({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkWell(
        // "https://firebasestorage.googleapis.com/v0/b/musix-dc275.appspot.com/o/YeuEmHonMoiNgay-Andiez-7136374.mp3?alt=media&token=2f6c8d7b-b7c8-4c56-a203-fd8a6478cbaf"
        onTap: () => {
          audioPlayerProvider.updateSongUrl(
              "https://firebasestorage.googleapis.com/v0/b/musix-dc275.appspot.com/o/YeuEmHonMoiNgay-Andiez-7136374.mp3?alt=media&token=2f6c8d7b-b7c8-4c56-a203-fd8a6478cbaf"),
          audioPlayerProvider.playAudio()
        },
        child: Row(
          children: [
            Text(
              "#${index + 1}",
              style: kDefaultTitleStyle.copyWith(fontSize: 16),
            ),
            horizontalSpaceSmall,
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  image: const DecorationImage(
                      image: AssetImage("assets/images/charlie_puth.jpg"),
                      fit: BoxFit.cover)),
            ),
            horizontalSpaceSmall,
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Girl like you",
                        style: kDefaultTitleStyle.copyWith(fontSize: 16),
                      ),
                      Text(
                        "Avinci John",
                        style: kDefaultTitleStyle.copyWith(
                            fontSize: 16, color: kPrimaryColor),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(
                      Icons.arrow_downward,
                      color: kPrimaryColor,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
