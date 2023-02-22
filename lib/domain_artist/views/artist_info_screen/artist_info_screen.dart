import 'package:flutter/material.dart';
import 'package:musix/domain_album/models/album.dart';
import 'package:musix/domain_album/views/widgets/album_list_widget.dart';
import 'package:musix/domain_music/views/widgets.dart';

import '../../../theme/theme.dart';

class ArtistInfoScreen extends StatelessWidget {
  const ArtistInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String imgTopic =
        'https://plus.unsplash.com/premium_photo-1664303602827-655efc7415da?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80';
    return Scaffold(
      backgroundColor: ColorTheme.background,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: size.width,
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
                      imgTopic,
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '22',
                              style: TextStyleTheme.ts16.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Playlists',
                              style: TextStyleTheme.ts14.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '360 K',
                              style: TextStyleTheme.ts16.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Followers',
                              style: TextStyleTheme.ts14.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '56',
                              style: TextStyleTheme.ts16.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Following',
                              style: TextStyleTheme.ts14.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      'Arian Grande',
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
                      '26 Jan 1990',
                      style: TextStyleTheme.ts14.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorTheme.primaryLighten,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text.rich(
                      TextSpan(children: <InlineSpan>[
                        const TextSpan(
                            text:
                                'Ariana Grande-Butera is an American singer, songwriter, and actress. Born in Boca Raton, Florida, Grande began her career in the 2008 Broadway musical 13 and rose to prominence for her role as Cat Valentine in the Nickelodeon television series Victorious, and in its spin-off, Sam & Cat'),
                        TextSpan(
                          text: '\tShow More',
                          style: TextStyleTheme.ts14.copyWith(
                            fontWeight: FontWeight.w400,
                            color: ColorTheme.primary,
                          ),
                        ),
                      ]),
                      style: TextStyleTheme.ts14.copyWith(
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorTheme.primary,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Follow',
                              style: TextStyleTheme.ts16.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            const Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.white,
                            )
                          ],
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              AlbumListWidget(
                title: 'Album',
                albums: sampleListAlbum,
                isShowAll: false,
                albumArrange: AlbumArrange.list,
                isScrollable: true,
              ),
              const SizedBox(
                height: 12,
              ),
              SongListWidget(
                title: 'All Songs',
                songs: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
