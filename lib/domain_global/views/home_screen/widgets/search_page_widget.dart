import 'package:flutter/material.dart';
import 'package:musix/domain_artist/views/widgets.dart';
import 'package:musix/domain_global/views/widgets.dart';
import 'package:musix/domain_music/views/widgets.dart';

import '../../../../domain_album/views/widgets.dart';
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
    _tabController = TabController(length: 4, vsync: this)
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
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, value) {
        return [
          SliverToBoxAdapter(
            child: SearchBarWidget(
              hintText: widget.homeTextPath.searchByName,
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
              unselectedLabelColor: ColorTheme.gray100,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorTheme.primary,
              ),
              tabs: [
                Tab(
                  text: widget.homeTextPath.all,
                  icon: const Icon(Icons.star_border),
                  iconMargin: const EdgeInsets.all(8),
                ),
                Tab(
                  text: widget.homeTextPath.song,
                  icon: const Icon(Icons.music_note),
                  iconMargin: const EdgeInsets.all(8),
                ),
                Tab(
                  text: widget.homeTextPath.artist,
                  icon: const Icon(Icons.person),
                  iconMargin: const EdgeInsets.all(8),
                ),
                Tab(
                  text: widget.homeTextPath.album,
                  icon: const Icon(Icons.album_outlined),
                  iconMargin: const EdgeInsets.all(8),
                ),
              ],
            ),
          )
        ];
      },
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: TabBarView(controller: _tabController, children: const [
          SearchAllWidget(),
          SearchMusicWidget(),
          SearchArtistWidget(),
          SearchAlbumWidget(),
        ]),
      ),
    );
  }
}
