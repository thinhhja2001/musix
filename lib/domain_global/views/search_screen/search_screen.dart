import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/exporter.dart';
import '../../../domain_artist/views/widgets.dart';
import '../../../domain_hub/entities/entities.dart';
import '../../../domain_playlist/views/widgets.dart';
import '../../../domain_song/views/widgets.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';
import '../widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isShowSearch = false;
  int _currentIndex = 0;
  GlobalKey key = GlobalKey();
  Timer? searchOnStoppedTyping;

  _onChangeHandler(value) {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping?.cancel());
    }
    setState(
        () => searchOnStoppedTyping = Timer(duration, () => search(value)));
  }

  search(value) {
    if (value == null) return;
    key.currentContext
        ?.read<SearchMusicBloc>()
        .add(SearchMusicQueryEvent(value));
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this)
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
    return Scaffold(
      key: key,
      backgroundColor: ColorTheme.background,
      persistentFooterButtons: [CurrentSongPlayerWidget()],
      body: SafeArea(
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, value) {
            return [
              const SliverPadding(
                padding: EdgeInsets.only(
                  top: DistinctConstant.small,
                ),
              ),
              SliverToBoxAdapter(
                child: SearchBarWidget(
                  hintText: r'What do you want to hear?',
                  recommends: const [],
                  onTextChange: _onChangeHandler,
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
                            if (_tabController.index == 3) ...[
                              const Icon(Icons.album_outlined),
                              const SizedBox(
                                width: 4,
                              ),
                            ],
                            Text(
                              'Playlists',
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      SearchAllWidget(
                        title: 'Top Searching',
                        listDynamic: [],
                        isShowIndex: false,
                        isScrollable: true,
                      ),
                      SongListWidget(
                        songArrange: SongArrange.info,
                        isScrollable: true,
                        isShowIndex: false,
                        sectionSong: SectionSong(
                          title: 'Top Song',
                          items: [],
                        ),
                      ),
                      ArtistListWidget(
                        artistArrange: ArtistArrange.info,
                        isScrollable: true,
                        isShowIndex: false,
                        sectionArtist: SectionArtist(
                          title: 'Top Artist',
                          items: [],
                        ),
                      ),
                      PlaylistListWidget(
                        playlistArrange: PlaylistArrange.image,
                        isScrollable: true,
                        sectionPlaylist: SectionPlaylist(
                          title: 'Top Album',
                          items: [],
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
        ),
      ),
    );
  }
}
