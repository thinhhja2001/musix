import 'package:flutter/material.dart';
import 'package:musix/domain_artist/models/models.dart';

import '../../../global/widgets/widgets.dart';
import '../widgets.dart';

class SearchArtistWidget extends StatelessWidget {
  final String title;
  final List<Artist?> artists;
  final bool isShowIndex;
  const SearchArtistWidget({
    Key? key,
    required this.title,
    required this.artists,
    this.isShowIndex = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RotatedTextWidget(text: title),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SizedBox(
            height: 10 * 56,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: artists.length,
                itemBuilder: (context, index) {
                  return ArtistCardWidget(
                    artist: artists[index] ?? sampleArtist,
                    index: index + 1,
                    isRequestIndex: isShowIndex,
                  );
                }),
          ),
        )
      ],
    );
  }
}
