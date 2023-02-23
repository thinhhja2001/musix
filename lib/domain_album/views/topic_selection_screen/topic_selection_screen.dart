import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:musix/domain_album/entities/entities.dart';
import 'package:musix/domain_album/logic/playlist_bloc.dart';
import 'package:musix/routing/routing_path.dart';
import 'package:musix/theme/color.dart';
import 'package:musix/theme/text_style.dart';

import '../../../global/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../widgets.dart';

class TopicSelectionScreen extends StatelessWidget {
  const TopicSelectionScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.read<PlaylistBloc>().add(const PlaylistBackListEvent());
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
      body: BlocBuilder<PlaylistBloc, PlaylistState>(
        builder: (context, state) {
          if (state.status?[PlaylistStatusKey.playlists.key] ==
              Status.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final List<Topic?>? topics = state.topics;
            if (topics == null) {
              return const SizedBox.shrink();
            } else {
              return Stack(
                children: [
                  const BlurBackgroundWidget(
                    imageUrl: AssetPath.group5,
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    child: ListView.builder(
                        itemCount: state.topics?.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (state.topics?[index] == null) {
                            return const SizedBox.shrink();
                          }
                          final Topic topic = state.topics![index]!;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 24,
                            ),
                            child: MasonryGridView.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 24,
                              crossAxisSpacing: 24,
                              itemCount: topic.items?.length ?? 0 + 1,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return SizedBox(
                                    height: 48,
                                    child: Text(
                                      topic.title!,
                                      style: TextStyleTheme.ts28.copyWith(
                                        fontSize:
                                            topic.title!.length > 10 ? 22 : 28,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }
                                return TopicCardWidget(
                                  miniPlaylist: topic.items?[index - 1] ??
                                      sampleMiniPlaylist,
                                  index: index - 1,
                                  height: 180,
                                  onPress: () {
                                    context.read<PlaylistBloc>().add(
                                          PlaylistGetInfoEvent(topic
                                              .items![index - 1].encodeId!),
                                        );
                                    Navigator.of(context).pushNamed(
                                      RoutingPath.albumInfo,
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        }),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}
