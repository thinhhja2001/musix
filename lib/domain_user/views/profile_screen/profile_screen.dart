import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../config/exporter.dart';
import '../../../domain_hub/entities/entities.dart';
import '../../../domain_song/views/widgets.dart';
import '../../../routing/routing_path.dart';
import '../../../theme/theme.dart';
import 'widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.height * 0.4,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const ProfileAvatarWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 28,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        BlocSelector<ProfileBloc, ProfileState, String?>(
                          selector: (state) {
                            return state.user?.profile?.fullName;
                          },
                          builder: (context, fullName) {
                            return Text(
                              fullName ?? "Anonymous",
                              style: TextStyleTheme.ts28.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        BlocSelector<ProfileBloc, ProfileState, String?>(
                          selector: (state) {
                            return state.user?.profile?.birthday;
                          },
                          builder: (context, birthday) {
                            return Text(
                              birthday ?? "None",
                              style: TextStyleTheme.ts14.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ColorTheme.primaryLighten,
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => const EditProfileWidget());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorTheme.primaryLighten,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          child: Text(
                            'Setting',
                            style: TextStyleTheme.ts16.copyWith(
                              fontWeight: FontWeight.w400,
                              color: ColorTheme.backgroundDarker,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(const AuthLogoutEvent());
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              RoutingPath.signIn,
                              (Route<dynamic> route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          child: Text(
                            'Logout',
                            style: TextStyleTheme.ts16.copyWith(
                              fontWeight: FontWeight.w400,
                              color: ColorTheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'My Library',
                          style: TextStyleTheme.ts20.copyWith(
                            color: ColorTheme.backgroundDarker,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 36,
                        ),
                        BlocSelector<UserMusicBloc, UserMusicState,
                            List<String>>(
                          selector: (state) {
                            return state.music?.favoritePlaylists ?? [];
                          },
                          builder: (context, favoritePlaylists) {
                            return LibraryButtonWidget(
                              title: 'Favorite Playlist',
                              icon: MdiIcons.music,
                              onTap: () {
                                context.read<PlaylistsBloc>().add(
                                    GetPlaylistsEvent(
                                        playlistIds: favoritePlaylists,
                                        title: 'Favorite Playlist'));
                                Navigator.of(context)
                                    .pushNamed(RoutingPath.playlistsInfo);
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        BlocSelector<UserMusicBloc, UserMusicState,
                            List<String>>(
                          selector: (state) {
                            return state.music?.dislikePlaylists ?? [];
                          },
                          builder: (context, dislikePlaylists) {
                            return LibraryButtonWidget(
                              title: 'Block Playlist',
                              icon: MdiIcons.musicOff,
                              onTap: () {
                                context.read<PlaylistsBloc>().add(
                                    GetPlaylistsEvent(
                                        playlistIds: dislikePlaylists,
                                        title: 'Block Playlist'));
                                Navigator.of(context)
                                    .pushNamed(RoutingPath.playlistsInfo);
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        BlocSelector<UserMusicBloc, UserMusicState,
                            List<String>>(
                          selector: (state) {
                            return state.music?.favoriteArtists ?? [];
                          },
                          builder: (context, favoriteArtists) {
                            return LibraryButtonWidget(
                              title: 'Favorite Artist',
                              icon: MdiIcons.accountStarOutline,
                              onTap: () {
                                context.read<ArtistsBloc>().add(GetArtistsEvent(
                                    aliasList: favoriteArtists,
                                    title: 'Favorite Artist'));
                                Navigator.of(context)
                                    .pushNamed(RoutingPath.artistsInfo);
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        BlocSelector<UserMusicBloc, UserMusicState,
                            List<String>>(
                          selector: (state) {
                            return state.music?.dislikeArtists ?? [];
                          },
                          builder: (context, dislikeArtists) {
                            return LibraryButtonWidget(
                              title: 'Block Artist',
                              icon: MdiIcons.accountRemoveOutline,
                              onTap: () {
                                context.read<ArtistsBloc>().add(GetArtistsEvent(
                                    aliasList: dislikeArtists,
                                    title: 'Block Artist'));
                                Navigator.of(context)
                                    .pushNamed(RoutingPath.artistsInfo);
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        BlocSelector<UserMusicBloc, UserMusicState,
                            List<String>>(
                          selector: (state) {
                            return state.music?.favoriteSongs ?? [];
                          },
                          builder: (context, favoriteSongs) {
                            return LibraryButtonWidget(
                              title: 'Favorite Song',
                              icon: MdiIcons.musicClefTreble,
                              onTap: () {
                                context.read<SongsBloc>().add(GetSongsEvent(
                                    songIds: favoriteSongs,
                                    title: 'Favorite Song'));
                                Navigator.of(context)
                                    .pushNamed(RoutingPath.songsInfo);
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        BlocSelector<UserMusicBloc, UserMusicState,
                            List<String>>(
                          selector: (state) {
                            return state.music?.dislikeSongs ?? [];
                          },
                          builder: (context, dislikeSongs) {
                            return LibraryButtonWidget(
                              title: 'Dislike Song',
                              icon: MdiIcons.musicAccidentalDoubleSharp,
                              onTap: () {
                                context.read<SongsBloc>().add(GetSongsEvent(
                                    songIds: dislikeSongs,
                                    title: 'Dislike Song'));
                                Navigator.of(context)
                                    .pushNamed(RoutingPath.songsInfo);
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        LibraryButtonWidget(
                          title: 'Own Playlists',
                          icon: MdiIcons.musicBoxMultiple,
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(RoutingPath.ownPlaylists);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const SongListWidget(
                    sectionSong: SectionSong(
                      title: 'Recent Songs',
                      items: [],
                    ),
                    isScrollable: false,
                    isShowIndex: true,
                    songArrange: SongArrange.info,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LibraryButtonWidget extends StatelessWidget {
  const LibraryButtonWidget({
    super.key,
    required this.title,
    this.onTap,
    required this.icon,
  });
  final String title;
  final VoidCallback? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: ColorTheme.primaryLighten,
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            icon,
            size: 24,
            color: ColorTheme.primary,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyleTheme.ts16.copyWith(
                color: ColorTheme.backgroundDarker,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // const Icon(
          //   Icons.more_horiz_rounded,
          //   size: 24,
          //   color: ColorTheme.primary,
          // ),
        ],
      ),
    );
  }
}
