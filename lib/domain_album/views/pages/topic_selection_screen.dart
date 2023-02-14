import 'package:flutter/material.dart';
import 'package:musix/domain_album/models/models.dart';
import 'package:musix/theme/color.dart';
import 'package:musix/theme/text_style.dart';

class TopicSelectionScreen extends StatelessWidget {
  const TopicSelectionScreen({
    Key? key,
    required this.topic,
  }) : super(key: key);

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.primaryLighten,
      appBar: AppBar(
        title: Text(
          topic.title,
          style: TextStyleTheme.ts18.copyWith(
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
