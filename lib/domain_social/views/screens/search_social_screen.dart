import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_global/views/search_screen/widgets.dart';
import 'package:musix/domain_user/entities/entities.dart';
import 'package:musix/global/widgets/widgets.dart';
import 'package:musix/routing/routing_path.dart';
import 'package:musix/theme/theme.dart';
import 'package:musix/utils/utils.dart';

import '../../entities/entities.dart';
import '../widgets/posts/post_card_widget.dart';

class SearchSocialScreen extends StatefulWidget {
  const SearchSocialScreen({Key? key}) : super(key: key);

  @override
  State<SearchSocialScreen> createState() => _SearchSocialScreenState();
}

class _SearchSocialScreenState extends State<SearchSocialScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _postScrollController;
  GlobalKey key = GlobalKey<_SearchSocialScreenState>();
  Timer? searchOnStoppedTyping;
  bool _loading = false;

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
        ?.read<SocialSearchBloc>()
        .add(SearchAllSocialEvent(value));
  }

  List<Widget> _buildTab() {
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
              'Posts',
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
              'Users',
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
  }

  void _onScroll() {
    if (!_postScrollController.hasClients || _loading) return;
    if (_postScrollController.position.pixels ==
        _postScrollController.position.maxScrollExtent) {
      _loading = true;
      context.read<SocialSearchBloc>().add(const SearchMorePostEvent());
      _loading = false;
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _postScrollController = ScrollController()..addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
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
      ),
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
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
                      hintText: r'What do you want to search?',
                      recommends: const [],
                      onTextChange: _onChangeHandler,
                      onClear: () => key.currentContext
                          ?.read<SocialSearchBloc>()
                          .add(const ClearSearchEvent()),
                    ),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.only(
                      top: DistinctConstant.small,
                    ),
                  ),
                  BlocSelector<SocialSearchBloc, SocialSearchState, bool>(
                    selector: (state) {
                      if (state.values != null) return true;
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
              body: BlocBuilder<SocialSearchBloc, SocialSearchState>(
                builder: (context, state) {
                  if (state.status![SocialSearchStatusKey.global.name] ==
                      Status.loading) {
                    return const Center(
                        child: SpinKitPulse(
                      color: ColorTheme.primary,
                      size: 100,
                    ));
                  }
                  if (state.search == null &&
                      state.status![SocialSearchStatusKey.global.name] ==
                          Status.idle) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.newspaper,
                            size: 24,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Search anything you wanna find',
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
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        BlocSelector<SocialSearchBloc, SocialSearchState,
                            List<Post>>(
                          selector: (state) {
                            return state.values?.posts ?? [];
                          },
                          builder: (context, posts) {
                            if (posts.isEmpty) {
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
                            return ListView.separated(
                              controller: _postScrollController,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 24,
                                );
                              },
                              itemCount: posts.length,
                              itemBuilder: (context, index) {
                                return PostCardWidget(
                                    post: posts.elementAt(index));
                              },
                            );
                          },
                        ),
                        BlocSelector<SocialSearchBloc, SocialSearchState,
                            List<User>>(
                          selector: (state) {
                            return state.values?.users ?? [];
                          },
                          builder: (context, users) {
                            if (users.isEmpty == true) {
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
                            return ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 24,
                                );
                              },
                              itemCount: users.length,
                              itemBuilder: (context, index) {
                                return CustomCardInfoWidget(
                                  index: index,
                                  image: users[index].profile?.avatarUrl ??
                                      AssetPath.userUnknownImage,
                                  title: users[index].profile?.fullName ??
                                      "Anonymous",
                                  padding: 0,
                                  onCardPress: () {
                                    Navigator.of(context).pushNamed(
                                        RoutingPath.profileSocial,
                                        arguments: users[index]);
                                  },
                                  isShowAdditionButton: false,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
