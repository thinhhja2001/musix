import 'package:flutter/material.dart';

import '../../../routing/routing_path.dart';
import '../../../theme/text_style.dart';
import '../../models/models.dart';

class ViewSongDetailWidget extends StatelessWidget {
  const ViewSongDetailWidget({
    super.key,
    required this.song,
  });
  final SongInfo song;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.network(
              song.thumbnailM,
              height: 200,
              width: 200,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              song.title,
              style: TextStyleTheme.ts20.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              song.artistsNames,
              style: TextStyleTheme.ts15.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ViewSongDetailChildComponent(
                  icon: Icons.favorite_outline,
                  data: "Like",
                  onPress: () {},
                ),
                _ViewSongDetailChildComponent(
                  icon: Icons.playlist_add,
                  data: "Add to playlist",
                  onPress: () {},
                ),
                _ViewSongDetailChildComponent(
                  icon: Icons.person_search_outlined,
                  data: "View artist",
                  onPress: () {
                    Navigator.of(context).pushNamed(
                      RoutingPath.artistInfo,
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ViewSongDetailChildComponent extends StatelessWidget {
  const _ViewSongDetailChildComponent({
    required this.icon,
    required this.data,
    required this.onPress,
  });
  final IconData icon;
  final String data;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            data,
            style: TextStyleTheme.ts20.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
