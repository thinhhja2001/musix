import 'package:flutter/material.dart';

import '../../../global/widgets/widgets.dart';
import '../../models/models.dart';
import '../widgets.dart';

class SearchVideoWidget extends StatelessWidget {
  const SearchVideoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const RotatedTextWidget(text: 'Top Videos'),
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
                  return VideosSelectionWidget(
                    video: sampleVideo,
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
