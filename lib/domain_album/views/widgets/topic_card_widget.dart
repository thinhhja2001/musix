import 'package:flutter/material.dart';
import 'package:musix/domain_album/models/models.dart';
import 'package:musix/global/widgets/custom_card_widget.dart';
import 'package:musix/theme/text_style.dart';

class TopicCardWidget extends StatelessWidget {
  final Topic topic;
  final Size? size;
  final int? index;
  final VoidCallback? onTap;
  const TopicCardWidget({
    Key? key,
    required this.topic,
    this.size,
    this.index,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      image: topic.image,
      onTap: onTap,
      width: size?.width ?? 100,
      height: size?.height ?? 60,
      title: topic.title,
      titleAlignment: Alignment.center,
      titleTextStyle: TextStyleTheme.ts18.copyWith(
        fontWeight: FontWeight.w400,
      ),
      opacityTitle: false,
    );
  }
}
