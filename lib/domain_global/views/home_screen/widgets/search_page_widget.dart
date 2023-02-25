import 'package:flutter/material.dart';
import 'package:musix/domain_hub/entities/entities.dart';

import '../../../../domain_artist/views/widgets.dart';
import '../../../../domain_music/models/models.dart';
import '../../../../domain_music/views/widgets.dart';
import '../../../../domain_playlist/views/widgets.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/fake_data/sample_list.dart';
import '../../../../utils/utils.dart';
import '../../widgets.dart';
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
  bool _isShowSearch = false;
  int _currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this)
      ..addListener(() {
        setState(() {
          _currentIndex = _tabController.index;
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      physics: const NeverScrollableScrollPhysics(),
      headerSliverBuilder: (context, value) {
        return [
          SliverToBoxAdapter(
            child: SearchBarWidget(
              hintText: widget.homeTextPath.searchBarHintText,
              recommends: recommends,
              onTextChange: (value) {
                DebugLogger().log(value);
                if (value != "") {
                  if (!_isShowSearch) {
                    setState(() {
                      _isShowSearch = true;
                    });
                  }
                } else {
                  if (_isShowSearch) {
                    setState(() {
                      _isShowSearch = false;
                    });
                  }
                }
              },
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(
              top: DistinctConstant.small,
            ),
          ),
          if (_isShowSearch) ...[
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
          ],
        ];
      },
      body: _isShowSearch
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TabBarView(
                controller: _tabController,
                children: [
                  SearchAllWidget(
                    title: 'Top Searching',
                    listDynamic: sampleAllList,
                    isShowIndex: false,
                    isScrollable: true,
                  ),
                  const SongListWidget(
                    songArrange: SongArrange.info,
                    isScrollable: true,
                    isShowIndex: false,
                    sectionSong: SectionSong(
                      title: 'Top Song',
                    ),
                  ),
                  VideoListWidget(
                    title: 'Top Videos',
                    videos: sampleVideoList,
                    isShowIndex: false,
                    isScrollable: true,
                  ),
                  const ArtistListWidget(
                    artistArrange: ArtistArrange.info,
                    isScrollable: true,
                    isShowIndex: false,
                    sectionArtist: SectionArtist(
                      title: 'Top Artist',
                    ),
                  ),
                  const PlaylistListWidget(
                    playlistArrange: PlaylistArrange.image,
                    isScrollable: true,
                    sectionPlaylist: SectionPlaylist(
                      title: 'Top Album',
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.favorite_border_outlined,
                    size: 24,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Please share with us your favorite song',
                    style: TextStyleTheme.ts15.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
