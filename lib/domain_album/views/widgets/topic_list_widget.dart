import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_album/entities/entities.dart';
import 'package:musix/domain_album/logic/playlist_bloc.dart';

import '../../../global/widgets/widgets.dart';
import '../../../routing/routing_path.dart';
import '../widgets.dart';

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
                itemCount: 1,
                itemBuilder: (context, index) {
                  return TopicCardWidget(
                    miniPlaylist: sampleMiniPlaylist,
                    index: index,
                    onPress: () {
                      context
                          .read<PlaylistBloc>()
                          .add(const PlaylistGetListEvent('IWZ9Z09U'));
                      Navigator.of(context).pushNamed(
                        RoutingPath.topicSelection,
                      );
                    },
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
