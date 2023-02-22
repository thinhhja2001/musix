import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../widgets.dart';
import '../../../routing/routing_path.dart';

import '../../../global/widgets/widgets.dart';

class TopicListWidget extends StatelessWidget {
  final String title;
  final List<Topic?> topics;
  const TopicListWidget({
    Key? key,
    required this.title,
    required this.topics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          RotatedTextWidget(text: title),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: SizedBox(
              height: 240,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: topics.length,
                itemBuilder: (context, index) {
                  return TopicCardWidget(
                    topic: topics[index] ?? sampleTopic,
                    index: index,
                    onPress: () => Navigator.of(context).pushNamed(
                      RoutingPath.topicSelection,
                      arguments: topics[index] ?? sampleTopic,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
