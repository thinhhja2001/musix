import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../home_screen/home_screen.dart';
import '../../../theme/color.dart';
import '../../../theme/text_style.dart';
import '../../../utils/constant/asset_path.dart';

import '../../../global/screens/slash_screen.dart';

class SlashHomeScreen extends StatelessWidget {
  const SlashHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: SvgPicture.asset(
        AssetPath.appIcon,
      ),
      title: Text(
        "Musix",
        style: TextStyleTheme.ts16.copyWith(
          fontWeight: FontWeight.w700,
          color: ColorTheme.primaryLighten,
        ),
      ),
      backgroundColor: ColorTheme.backgroundDarker,
      showLoader: false,
      navigator: const HomeScreen(),
      durationInSeconds: 3,
    );
  }
}
