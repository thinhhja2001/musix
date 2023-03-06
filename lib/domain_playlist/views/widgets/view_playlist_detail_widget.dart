import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_playlist/entities/entities.dart';

import '../../../config/exporter.dart';
import '../../../global/widgets/widgets.dart';
import '../../../routing/routing_path.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';

class ViewPlaylistDetailWidget extends StatelessWidget {
  const ViewPlaylistDetailWidget({
    super.key,
    required this.playlist,
  });
  final MiniPlaylist playlist;
  @override
  Widget build(BuildContext context) {
    List<String> artists = playlist.artistsNames?.split(',') ?? [];
    bool isMultipleArtist = false;
    if (artists.length != playlist.artistAlias?.length) {
      isMultipleArtist = true;
    }
    return Container(
      decoration: const BoxDecoration(
        color: ColorTheme.backgroundDarker,
        borderRadius: BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
      ),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              playlist.thumbnailM ?? AssetPath.placeImage,
              height: 200,
              width: 200,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            playlist.title ?? "",
            style: TextStyleTheme.ts20.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text.rich(
            TextSpan(
              children: <InlineSpan>[
                if (artists.isEmpty || isMultipleArtist) ...[
                  TextSpan(
                    text: playlist.artistsNames,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.read<ArtistBloc>().add(
                            ArtistGetInfoEvent(playlist.artistAlias!.first));
                        Navigator.of(context).pushNamed(
                          RoutingPath.artistInfo,
                        );
                      },
                  )
                ] else
                  ...List.generate(
                    artists.length,
                    (index) => TextSpan(
                        text: artists[index],
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.read<ArtistBloc>().add(ArtistGetInfoEvent(
                                playlist.artistAlias![index]));
                            Navigator.of(context).pushNamed(
                              RoutingPath.artistInfo,
                            );
                          },
                        children: index < artists.length - 1
                            ? const [TextSpan(text: ', ')]
                            : null),
                  ),
              ],
            ),
            style: TextStyleTheme.ts15.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DetailChildWidget(
            icon: Icons.favorite_outline,
            data: "Like",
            onPress: () {},
          ),
          const SizedBox(
            height: 12,
          ),
          DetailChildWidget(
            icon: Icons.do_not_disturb_alt_outlined,
            data: "Block",
            onPress: () {},
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}