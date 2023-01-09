import 'package:flutter/material.dart';

import '../../../global/widgets/widgets.dart';

class SearchAlbumWidget extends StatelessWidget {
  const SearchAlbumWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        RotatedTextWidget(text: 'ALBUM'),
        Text('SEARCH ALBUM'),
      ],
    );
  }
}
