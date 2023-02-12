import 'package:flutter/material.dart';
import 'package:musix/domain_album/models/album.dart';
import 'package:musix/domain_artist/models/artist.dart';
import 'package:musix/domain_artist/views/widgets.dart';
import 'package:musix/domain_global/views/widgets.dart';
import 'package:musix/domain_music/views/widgets.dart';

import '../../../../domain_album/views/widgets.dart';
import '../../../../domain_music/models/models.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/utils.dart';
import '../utils/text_path.dart';

class SearchPageWidget extends StatefulWidget {
  final HomeTextPath homeTextPath;
  const SearchPageWidget({
    Key? key,
    required this.homeTextPath,
  }) : super(key: key);

  @override
  State<SearchPageWidget> createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  bool _fixedScroll = false;
  int _currentIndex = 0;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_fixedScroll) {
          _scrollController.jumpTo(0);
        }
      });
    _tabController = TabController(length: 5, vsync: this)
      ..addListener(() {
        _scrollController.animateTo(
          0,
          duration: const Duration(microseconds: 300),
          curve: Curves.ease,
        );

        setState(() {
          _fixedScroll = _tabController.index != _currentIndex;
          _currentIndex = _tabController.index;
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String?> recommends = [
      'Chairlie Puth',
      'Fall Out Boy',
      'Fall Out Lucky Boy',
      'Happy',
    ];
    recommends.sort((a, b) => a!.length.compareTo(b!.length));
    return NestedScrollView(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      headerSliverBuilder: (context, value) {
        return [
          SliverToBoxAdapter(
            child: SearchBarWidget(
              hintText: widget.homeTextPath.searchBarHintText,
              recommends: recommends,
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(
              top: DistinctConstant.small,
            ),
          ),
          SliverToBoxAdapter(
            child: TabBar(
              controller: _tabController,
              labelColor: ColorTheme.white,
              unselectedLabelColor: ColorTheme.grey100,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorTheme.primary,
              ),
              isScrollable: true,
              tabs: [
                Tab(
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_tabController.index == 0) ...[
                        const Icon(Icons.star_border),
                        const SizedBox(
                          width: 4,
                        ),
                      ],
                      Text(
                        'All',
                        style: TextStyleTheme.ts15.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  iconMargin: const EdgeInsets.all(4),
                ),
                Tab(
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_tabController.index == 1) ...[
                        const Icon(Icons.music_note),
                        const SizedBox(
                          width: 4,
                        ),
                      ],
                      Text(
                        'Songs',
                        style: TextStyleTheme.ts15.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  iconMargin: const EdgeInsets.all(4),
                ),
                Tab(
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_tabController.index == 2) ...[
                        const Icon(Icons.play_arrow_rounded),
                        const SizedBox(
                          width: 4,
                        ),
                      ],
                      Text(
                        'Videos',
                        style: TextStyleTheme.ts15.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  iconMargin: const EdgeInsets.all(4),
                ),
                Tab(
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_tabController.index == 3) ...[
                        const Icon(Icons.person),
                        const SizedBox(
                          width: 4,
                        ),
                      ],
                      Text(
                        'Artist',
                        style: TextStyleTheme.ts15.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  iconMargin: const EdgeInsets.all(4),
                ),
                Tab(
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_tabController.index == 4) ...[
                        const Icon(Icons.album_outlined),
                        const SizedBox(
                          width: 4,
                        ),
                      ],
                      Text(
                        'Albums',
                        style: TextStyleTheme.ts15.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  iconMargin: const EdgeInsets.all(4),
                ),
              ],
            ),
          )
        ];
      },
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: TabBarView(
          controller: _tabController,
          children: [
            const SearchAllWidget(),
            SongListWidget(
              title: 'Top Songs',
              songs: sampleListSong,
              isShowIndex: false,
            ),
            VideoListWidget(
              title: 'Top Videos',
              videos: sampleVideoList,
              isShowIndex: false,
            ),
            SearchArtistWidget(
              title: 'Top Artists',
              artists: sampleArtistList,
              isShowIndex: false,
            ),
            AlbumListWidget(
              title: 'Top Albums',
              albums: sampleListAlbum,
              isShowAll: false,
              isArrangeByGrid: true,
            ),
          ],
        ),
      ),
    );
  }
}
