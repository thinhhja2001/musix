import 'package:flutter/material.dart';

import '../../../global/widgets/widgets.dart';

class SearchMusicWidget extends StatelessWidget {
  const SearchMusicWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        RotatedTextWidget(text: 'SONGS'),
        Text('SEARCH SONGS'),
      ],
    );
  }
}
