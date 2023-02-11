import 'package:flutter/material.dart';
import 'package:musix/domain_album/models/album.dart';
import 'package:musix/domain_album/views/widgets/album_selection_widget.dart';

import '../../../global/widgets/widgets.dart';

class SearchAlbumWidget extends StatelessWidget {
  const SearchAlbumWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          const RotatedTextWidget(text: 'Top Album'),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.84,
              ),
              itemBuilder: (context, index) => AlbumSelectionWidget(
                album: sampleAlbum,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
