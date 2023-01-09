import 'package:flutter/material.dart';

import '../../../global/widgets/widgets.dart';

class SearchAllWidget extends StatelessWidget {
  const SearchAllWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        RotatedTextWidget(text: 'ALL'),
        Text('SEARCH ALL'),
      ],
    );
  }
}
