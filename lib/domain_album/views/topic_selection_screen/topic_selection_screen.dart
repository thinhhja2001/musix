import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:musix/domain_album/entities/entities.dart';
import 'package:musix/domain_album/logic/playlist_bloc.dart';
import 'package:musix/domain_album/models/models.dart';
import 'package:musix/routing/routing_path.dart';
import 'package:musix/theme/color.dart';
import 'package:musix/theme/text_style.dart';

import '../../../global/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../widgets.dart';

class TopicSelectionScreen extends StatelessWidget {
  const TopicSelectionScreen({
    Key? key,
    required this.topic,
  }) : super(key: key);

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
            size: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const BlurBackgroundWidget(
            imageUrl: AssetPath.group5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              itemCount: topic.child.length + 1,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return SizedBox(
                    height: 48,
                    child: Text(
                      'Classic',
                      style: TextStyleTheme.ts28.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  );
                }
                return TopicCardWidget(
                  topic: topic.child[index - 1] ?? sampleTopic,
                  index: index - 1,
                  height: 180,
                  onPress: () {
                    context
                        .read<PlaylistBloc>()
                        .add(const PlaylistGetInfoEvent('ZU6Z07DU'));
                    Navigator.of(context).pushNamed(
                      RoutingPath.albumInfo,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? const Color(0xFF34568B),
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}
