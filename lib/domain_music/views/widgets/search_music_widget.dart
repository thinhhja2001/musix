import 'package:flutter/material.dart';

import '../../../global/widgets/widgets.dart';
import '../../models/song.dart';
import '../widgets.dart';

class SearchMusicWidget extends StatelessWidget {
  const SearchMusicWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const RotatedTextWidget(text: 'Top Songs'),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SizedBox(
            height: 10 * 56,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return SongSelectionWidget(
                    song: sampleSong,
                    index: index + 1,
                    isRequestIndex: false,
                  );
                }),
          ),
        )
      ],
    );
  }
}
