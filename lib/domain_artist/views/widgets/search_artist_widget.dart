import 'package:flutter/material.dart';

import '../../../global/widgets/widgets.dart';

class SearchArtistWidget extends StatelessWidget {
  const SearchArtistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        RotatedTextWidget(text: 'ARTIST'),
        Text('SEARCH ARTIST'),
      ],
    );
  }
}
