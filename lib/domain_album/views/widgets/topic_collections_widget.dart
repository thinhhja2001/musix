import 'package:flutter/material.dart';
import 'package:musix/domain_album/models/models.dart';
import 'package:musix/domain_album/views/widgets.dart';
import 'package:musix/routing/routing_path.dart';

import '../../../global/widgets/widgets.dart';

class TopicCollectionsWidget extends StatelessWidget {
  const TopicCollectionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          const RotatedTextWidget(text: 'Topics'),
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
                itemCount: 10,
                itemBuilder: (context, index) {
                  return TopicCardWidget(
                    topic: sampleTopic,
                    index: index,
                    onTap: () => Navigator.of(context).pushNamed(
                      RoutingPath.topicSelection,
                      arguments: sampleTopic,
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
