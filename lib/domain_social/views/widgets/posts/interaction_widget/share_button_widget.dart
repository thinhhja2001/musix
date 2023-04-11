import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';
import '../../../../entities/post/post.dart';

class ShareButtonWidget extends StatelessWidget {
  const ShareButtonWidget({
    super.key,
    required Post post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorTheme.white.withOpacity(.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.share,
              color: ColorTheme.white.withOpacity(.7),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "21.9K",
              style: TextStyleTheme.ts14.copyWith(color: ColorTheme.white),
            )
          ],
        ),
      ),
    );
  }
}
