import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/domain_music/models/models.dart';
import 'package:musix/domain_music/views/widgets.dart';
import 'package:musix/domain_user/views/profile_screen/widgets/edit_profile_widget.dart';

import '../../../theme/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String imgUser =
        'https://plus.unsplash.com/premium_photo-1664303602827-655efc7415da?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80';
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.01),
                      Colors.white.withOpacity(0.5),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      imgUser,
                    ),
                    fit: BoxFit.fitHeight,
                    opacity: 0.8,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 28,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.maybePop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'James Smith',
                      style: TextStyleTheme.ts28.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '26 Jan 1992',
                      style: TextStyleTheme.ts14.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorTheme.primaryLighten,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
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
                    SongListWidget(
                      title: 'Recent Music',
                      songs: sampleListSong,
                      isScrollable: false,
                      isShowIndex: true,
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
