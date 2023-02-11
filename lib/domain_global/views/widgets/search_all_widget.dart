import 'package:flutter/material.dart';

import '../../../domain_music/models/song.dart';
import '../../../domain_music/views/widgets.dart';
import '../../../global/widgets/widgets.dart';

class SearchAllWidget extends StatelessWidget {
  const SearchAllWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const RotatedTextWidget(text: 'Top Searching'),
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
                    isRequestIndex: false,
                    song: sampleSong,
                    index: index + 1,
                  );
                }),
          ),
        )
      ],
    );
  }
}
