import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../domain_video/views/widgets/video_short_list_widget.dart';

import '../../../config/exporter.dart';
import '../../../domain_artist/views/widgets.dart';
import '../../../domain_hub/entities/entities.dart';
import '../../../domain_playlist/views/widgets.dart';
import '../../../domain_song/views/widgets.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';
import '../../entities/entities.dart';
import '../widgets.dart';

enum SearchScreenType { song, video }

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
    required this.searchScreenType,
  }) : super(key: key);
  final SearchScreenType searchScreenType;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  GlobalKey key = GlobalKey();
  Timer? searchOnStoppedTyping;
  List<Widget> _buildTab() {
    switch (widget.searchScreenType) {
      case SearchScreenType.song:
        return [
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
        ];
      case SearchScreenType.video:
        [
          Tab(
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_tabController.index == 0) ...[
                  const Icon(Icons.video_library_outlined, size: 25),
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
          )
        ];
    }
    return [Container()];
  }

  _onChangeHandler(value) {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping?.cancel());
    }
    setState(
        () => searchOnStoppedTyping = Timer(duration, () => search(value)));
  }

  search(value) {
    if (value == null || value == '') return;
    key.currentContext
        ?.read<SearchMusicBloc>()
        .add(SearchMusicQueryEvent(value));
  }

  @override
  void initState() {
    _tabController = TabController(
        length: widget.searchScreenType == SearchScreenType.song ? 4 : 1,
        vsync: this);
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
      ),
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
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
                BlocSelector<SearchMusicBloc, SearchMusicState, bool>(
                  selector: (state) {
                    if (state.all != null) return true;
                    return false;
                  },
                  builder: (context, state) {
                    if (state == true) {
                      return SliverToBoxAdapter(
                        child: TabBar(
                            onTap: (value) => setState(() {
                                  _tabController.index = value;
                                }),
                            controller: _tabController,
                            labelColor: ColorTheme.white,
                            unselectedLabelColor: ColorTheme.grey100,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorTheme.primary,
                            ),
                            isScrollable: true,
                            tabs: _buildTab()),
                      );
                    } else {
                      return const SliverPadding(
                        padding: EdgeInsets.only(
                          top: 0,
                        ),
                      );
                    }
                  },
                )
              ];
            },
            body: BlocBuilder<SearchMusicBloc, SearchMusicState>(
              builder: (context, state) {
                if (state.status![SearchMusicStatusKey.global.key] ==
                    Status.loading) {
                  return const Center(
                      child: SpinKitPulse(
                    color: ColorTheme.primary,
                    size: 100,
                  ));
                }
                if (state.query == null &&
                    state.status![SearchMusicStatusKey.global.key] ==
                        Status.idle) {
                  return Center(
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
                  );
                }
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: widget.searchScreenType == SearchScreenType.song
                      ? TabBarView(
                          controller: _tabController,
                          children: [
                            BlocSelector<SearchMusicBloc, SearchMusicState,
                                SectionAll?>(
                              selector: (state) {
                                return state.all;
                              },
                              builder: (context, all) {
                                if (all == null || all.items?.isEmpty == true) {
                                  return Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.sentiment_dissatisfied_outlined,
                                          size: 24,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          r"Your request is too hard to find.",
                                          style: TextStyleTheme.ts15.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return SearchAllWidget(
                                  all: all,
                                  isShowIndex: false,
                                  isScrollable: false,
                                );
                              },
                            ),
                            BlocSelector<SearchMusicBloc, SearchMusicState,
                                SectionSong?>(
                              selector: (state) {
                                return state.songs;
                              },
                              builder: (context, songs) {
                                if (songs == null ||
                                    songs.items?.isEmpty == true) {
                                  return Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.sentiment_dissatisfied_outlined,
                                          size: 24,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          r"Your request is too hard to find.",
                                          style: TextStyleTheme.ts15.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return SongListWidget(
                                  songArrange: SongArrange.info,
                                  isScrollable: true,
                                  isShowIndex: true,
                                  sectionSong: songs,
                                  onScroll: () {
                                    key.currentContext
                                        ?.read<SearchMusicBloc>()
                                        .add(
                                            const SearchMusicSongLoadMoreEvent());
                                  },
                                );
                              },
                            ),
                            BlocSelector<SearchMusicBloc, SearchMusicState,
                                SectionArtist?>(
                              selector: (state) {
                                return state.artists;
                              },
                              builder: (context, artists) {
                                if (artists == null ||
                                    artists.items?.isEmpty == true) {
                                  return Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.sentiment_dissatisfied_outlined,
                                          size: 24,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          r"Your request is too hard to find.",
                                          style: TextStyleTheme.ts15.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return ArtistListWidget(
                                  artistArrange: ArtistArrange.info,
                                  isScrollable: true,
                                  isShowIndex: true,
                                  sectionArtist: artists,
                                  onScroll: () {
                                    key.currentContext?.read<SearchMusicBloc>().add(
                                        const SearchMusicArtistLoadMoreEvent());
                                  },
                                );
                              },
                            ),
                            BlocSelector<SearchMusicBloc, SearchMusicState,
                                SectionPlaylist?>(
                              selector: (state) {
                                return state.playlists;
                              },
                              builder: (context, playlists) {
                                if (playlists == null ||
                                    playlists.items?.isEmpty == true) {
                                  return Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.sentiment_dissatisfied_outlined,
                                          size: 24,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          r"Your request is too hard to find.",
                                          style: TextStyleTheme.ts15.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return PlaylistListWidget(
                                  playlistArrange: PlaylistArrange.image,
                                  isScrollable: true,
                                  sectionPlaylist: playlists,
                                  onScroll: () {
                                    key.currentContext?.read<SearchMusicBloc>().add(
                                        const SearchMusicPlaylistLoadMoreEvent());
                                  },
                                );
                              },
                            ),
                          ],
                        )
                      : BlocSelector<SearchMusicBloc, SearchMusicState,
                          SectionVideo?>(
                          selector: (state) {
                            return state.videos;
                          },
                          builder: (context, videos) {
                            if (videos == null ||
                                videos.items?.isEmpty == true) {
                              return Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.sentiment_dissatisfied_outlined,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      r"Your request is too hard to find.",
                                      style: TextStyleTheme.ts15.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return VideoShortListWidget(
                              onScroll: () => context
                                  .read<SearchMusicBloc>()
                                  .add(SearchMusicVideoLoadMoreEvent()),
                              videoShortListType: VideoShortListType.list,
                              title: videos.title ?? "",
                              videos: videos.items ?? [],
                            );
                          },
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
