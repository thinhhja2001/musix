import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import '../../../domain_social/views/screens/social_screen.dart';
import '../../../domain_song/views/widgets.dart';
import '../../../domain_user/views/screens.dart';
import '../../../domain_video/views/screens/video_short_list_page_widget.dart';
import '../../../global/widgets/widgets.dart';
import '../../../routing/routing_path.dart';
import '../../../theme/theme.dart';
import 'widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int indexBottomNavigation = 0;
  @override
  void initState() {
    super.initState();
    _initDynamicLinks();
  }

  Future<void> _initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      // Split path with "/" pattern
      // Will return an array with ["", "screen type","id"]
      final dynamicLinkSplitted = dynamicLinkData.link.path.split("/");
      String navigateType = dynamicLinkSplitted.elementAt(1);
      String id = dynamicLinkSplitted.elementAt(2);
      switch (navigateType) {
        case "post":
          Navigator.pushNamed(context, RoutingPath.postDetail, arguments: id);
          break;
        default:
      }
    }).onError((error) {
      debugPrint("onLink error");
      debugPrint(error.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      persistentFooterButtons: [CurrentSongPlayerWidget()],
      persistentFooterAlignment: AlignmentDirectional.bottomEnd,
      bottomNavigationBar: CustomBottomBarWidget(
        items: bottomNavigationItems(context),
        index: indexBottomNavigation,
        onTap: (value) {
          setState(() {
            indexBottomNavigation = value;
          });
        },
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          child: IndexedStack(
            index: indexBottomNavigation,
            children: const [
              HomeMusicPage(),
              SocialScreen(),
              VideoShortListPageWidget(),
              ProfileScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
