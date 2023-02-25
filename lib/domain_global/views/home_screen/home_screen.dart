import 'package:flutter/material.dart';

import '../../../global/widgets/widgets.dart';
import '../../../theme/theme.dart';
import 'utils/text_path.dart';
import '../../../domain_video/views/screens/video_short_list_page_widget.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int indexBottomNavigation = 0;

  @override
  Widget build(BuildContext context) {
    final homeTextPath = HomeTextPath();
    return Scaffold(
      backgroundColor: ColorTheme.background,
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
            children: [
              const BillboardPageWidget(),
              const ExplorePageWidget(),
              SearchPageWidget(
                homeTextPath: homeTextPath,
              ),
              const VideoShortListPageWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
