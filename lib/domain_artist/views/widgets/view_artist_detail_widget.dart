import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/exporter.dart';
import '../../../global/widgets/widgets.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';
import '../../entities/entities.dart';

class ViewArtistDetailWidget extends StatelessWidget {
  const ViewArtistDetailWidget({
    super.key,
    required this.artist,
  });
  final MiniArtist artist;
  @override
  Widget build(BuildContext context) {
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
              artist.thumbnailM ?? AssetPath.placeImage,
              height: 200,
              width: 200,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            artist.name ?? "",
            style: TextStyleTheme.ts20.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocSelector<UserMusicBloc, UserMusicState, bool>(
            selector: (state) {
              List<String> artists = state.music?.favoriteArtists ?? [];
              return artists.contains(artist.alias);
            },
            builder: (context, isFollow) {
              return DetailChildWidget(
                icon: isFollow ? Icons.favorite : Icons.favorite_outline,
                data: "Follow",
                onPress: () {
                  context.read<UserMusicBloc>().add(FavoriteArtistEvent(
                        id: artist.id!,
                        name: artist.name!,
                        alias: artist.alias!,
                      ));
                },
              );
            },
          ),
          const SizedBox(
            height: 12,
          ),
          BlocSelector<UserMusicBloc, UserMusicState, bool>(
            selector: (state) {
              List<String> artists = state.music?.dislikeArtists ?? [];
              return artists.contains(artist.alias);
            },
            builder: (context, isDislike) {
              return DetailChildWidget(
                icon: isDislike
                    ? Icons.do_disturb_on
                    : Icons.do_not_disturb_alt_outlined,
                data: "Block",
                onPress: () {
                  context.read<UserMusicBloc>().add(DislikeArtistEvent(
                        id: artist.id!,
                        name: artist.name!,
                        alias: artist.alias!,
                      ));
                },
              );
            },
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
