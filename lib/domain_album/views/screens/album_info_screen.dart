import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/domain_music/models/models.dart';
import 'package:musix/domain_music/views/widgets.dart';

import '../../../theme/theme.dart';
import '../../models/models.dart';

class AlbumInfoScreen extends StatelessWidget {
  final Topic? topic;
  final Album? album;
  const AlbumInfoScreen({
    Key? key,
    this.topic,
    this.album,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const String imgTopic =
        'https://plus.unsplash.com/premium_photo-1664303602827-655efc7415da?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80';
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
            splashColor: Colors.white24,
            tooltip: 'Download',
            icon: Icon(
              MdiIcons.download,
              color: Colors.white.withOpacity(0.8),
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {},
            splashColor: Colors.red.withOpacity(0.2),
            tooltip: 'Favorite',
            icon: Icon(
              Icons.favorite,
              color: Colors.red.withOpacity(0.8),
              size: 24,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.shade900,
                    offset: const Offset(
                      2,
                      4,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: CachedNetworkImage(
                  imageUrl: imgTopic,
                  progressIndicatorBuilder: (context, _, __) {
                    return const Center(child: CircularProgressIndicator());
                  },
                  width: size.width,
                  height: size.height * 0.4,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Container(
                width: double.maxFinite,
                height: size.height * 0.8,
                decoration: BoxDecoration(
                  color: const Color(0xff383676),
                  borderRadius: BorderRadius.circular(36),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      blurRadius: 30,
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              'Baroque',
                              style: TextStyleTheme.ts22.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            tooltip: 'Shuffle',
                            icon: Center(
                              child: Icon(
                                MdiIcons.shuffle,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(180),
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Baroque music is a period or style of Western art music composed from approximately 1600 to 1750.',
                        style: TextStyleTheme.ts14.copyWith(
                          fontWeight: FontWeight.w300,
                          color: const Color(0xffE8BCD3),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: CachedNetworkImage(
                          imageUrl: imgTopic,
                          progressIndicatorBuilder: (context, _, __) {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                          width: size.width,
                          height: 160,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SongListWidget(
                        title: 'All Songs',
                        songs: sampleListSong,
                        isScrollable: false,
                        isShowIndex: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
