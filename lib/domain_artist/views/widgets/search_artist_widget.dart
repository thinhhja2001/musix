import 'package:flutter/material.dart';
import 'package:musix/domain_artist/models/models.dart';

import '../../../global/widgets/widgets.dart';
import '../widgets.dart';

class SearchArtistWidget extends StatelessWidget {
  const SearchArtistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const RotatedTextWidget(text: 'Top Artist'),
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
                  return ArtistSelectionWidget(
                    artist: sampleArtist,
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
