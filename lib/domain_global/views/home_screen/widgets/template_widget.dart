import 'package:flutter/material.dart';

import '../../../../global/widgets/widgets.dart';
import '../../../../utils/utils.dart';

class HomeTemplateWidget extends StatelessWidget {
  final Widget body;
  final Widget? sliverAppbar;
  final bool isNeedBackground;
  const HomeTemplateWidget({
    Key? key,
    required this.body,
    this.sliverAppbar,
    this.isNeedBackground = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BlurBackgroundWidget(
          imageUrl: AssetPath.group5,
        ),
        CustomScrollView(slivers: [
          if (sliverAppbar != null) sliverAppbar!,
          SliverFillRemaining(
            hasScrollBody: false,
            child: body,
          ),
        ]),
      ],
    );
  }
}
