import 'package:flutter/material.dart';

import '../../../domain_social/views/screens/social_screen.dart';
import '../../../domain_song/views/widgets.dart';
import '../../../domain_user/views/screens.dart';
import '../../../domain_video/views/screens/video_short_list_page_widget.dart';
import '../../../global/widgets/widgets.dart';
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
