import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../config/exporter.dart';
import '../../../domain_hub/entities/entities.dart';
import '../../../domain_song/views/widgets.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';
import 'widgets/edit_profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ColorTheme.background,
      body: SafeArea(
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
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                      child: ShaderMask(
                        shaderCallback: (bound) {
                          return LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.white.withOpacity(0.01),
                              Colors.white.withOpacity(0.4),
                            ],
                          ).createShader(bound);
                        },
                        blendMode: BlendMode.srcOver,
                        child: BlocSelector<ProfileBloc, ProfileState, String?>(
                          selector: (state) {
                            return state.user?.profile?.avatarUrl;
                          },
                          builder: (context, imgUrl) {
                            return CachedNetworkImage(
                              imageUrl: imgUrl ?? AssetPath.placeImage,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.fitWidth,
                            );
                          },
                        ),
                      ),
                    ),
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
                                builder: (context) =>
                                    const EditProfileWidget());
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
                          onPressed: () {},
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
                          InkWell(
                            splashColor: ColorTheme.primaryLighten,
                            onTap: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  MdiIcons.music,
                                  size: 24,
                                  color: ColorTheme.primary,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Text(
                                    'My Playlist',
                                    style: TextStyleTheme.ts16.copyWith(
                                      color: ColorTheme.backgroundDarker,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.more_horiz_rounded,
                                  size: 24,
                                  color: ColorTheme.primary,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          InkWell(
                            splashColor: ColorTheme.primaryLighten,
                            onTap: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  MdiIcons.contentCopy,
                                  size: 24,
                                  color: ColorTheme.primary,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Text(
                                    'Album',
                                    style: TextStyleTheme.ts16.copyWith(
                                      color: ColorTheme.backgroundDarker,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.more_horiz_rounded,
                                  size: 24,
                                  color: ColorTheme.primary,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          InkWell(
                            splashColor: ColorTheme.primaryLighten,
                            onTap: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  Icons.play_arrow_rounded,
                                  size: 24,
                                  color: ColorTheme.primary,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Text(
                                    'Videos',
                                    style: TextStyleTheme.ts16.copyWith(
                                      color: ColorTheme.backgroundDarker,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.more_horiz_rounded,
                                  size: 24,
                                  color: ColorTheme.primary,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          InkWell(
                            splashColor: ColorTheme.primaryLighten,
                            onTap: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  Icons.person_outline,
                                  size: 24,
                                  color: ColorTheme.primary,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Text(
                                    'Following',
                                    style: TextStyleTheme.ts16.copyWith(
                                      color: ColorTheme.backgroundDarker,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.more_horiz_rounded,
                                  size: 24,
                                  color: ColorTheme.primary,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          InkWell(
                            splashColor: ColorTheme.primaryLighten,
                            onTap: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  MdiIcons.cloudDownloadOutline,
                                  size: 24,
                                  color: ColorTheme.primary,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Text(
                                    'My Download',
                                    style: TextStyleTheme.ts16.copyWith(
                                      color: ColorTheme.backgroundDarker,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.more_horiz_rounded,
                                  size: 24,
                                  color: ColorTheme.primary,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
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
      ),
    );
  }
}
