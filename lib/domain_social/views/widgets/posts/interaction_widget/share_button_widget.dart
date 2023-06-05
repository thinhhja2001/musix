import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/domain_social/entities/utils/firebase_dynamic_link_generator.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../theme/theme.dart';
import '../../../../entities/post/post.dart';

class ShareButtonWidget extends StatelessWidget {
  final Post post;
  const ShareButtonWidget(
      {super.key, required this.post, this.isPostDetail = false});

  /// Whether it is being rendered in PostDetailScreen
  final bool isPostDetail;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isPostDetail ? null : ColorTheme.white.withOpacity(.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            final url =
                await FirebaseDynamicLinkGenerator.generateSharingPostLink(
                    post.id!);
            await Share.share(
              url.toString(),
            );
          },
          child: Icon(
            MdiIcons.share,
            color: ColorTheme.white.withOpacity(.7),
          ),
        ),
      ),
    );
  }
}
