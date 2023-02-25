import 'package:flutter/material.dart';

import '../../../../global/widgets/widgets.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/utils.dart';

class HubInfoScreen extends StatelessWidget {
  const HubInfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const BlurBackgroundWidget(
            imageUrl: AssetPath.group5,
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            child: ListView.builder(
                itemCount: 0,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // if (state.sectionPlaylist?[index] == null) {
                  //   return const SizedBox.shrink();
                  // }
                  // final SectionPlaylist sectionPlaylist =
                  //     state.sectionPlaylist![index];
                  return SizedBox();
                }),
          ),
        ],
      ),
    );
  }
}
