import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter/bloc_exporter.dart';
import 'package:musix/domain_artist/entities/entities.dart';

import '../../../global/widgets/widgets.dart';
import '../../../routing/routing_path.dart';
import '../widgets.dart';

class ArtistListWidget extends StatelessWidget {
  final String title;
  final List<MiniArtist?> artists;
  final bool isShowIndex;
  final bool isScrollable;

  const ArtistListWidget({
    Key? key,
    required this.title,
    required this.artists,
    this.isShowIndex = false,
    this.isScrollable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RotatedTextWidget(text: title),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: isScrollable
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(
                  artists.length,
                  (index) => ArtistCardWidget(
                    index: index + 1,
                    isRequestIndex: isShowIndex,
                    artist: artists[index] ?? sampleMiniArtist,
                    onPress: () {
                      context
                          .read<ArtistBloc>()
                          .add(ArtistGetInfoEvent(artists[index]!.alias!));
                      Navigator.of(context).pushNamed(
                        RoutingPath.artistInfo,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
