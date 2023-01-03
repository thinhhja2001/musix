import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class TemplateWidget extends StatelessWidget {
  final Widget header;
  final Widget body;
  final String coverImage;
  const TemplateWidget({
    Key? key,
    required this.coverImage,
    required this.header,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (rect) {
                            return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black,
                                  Colors.transparent,
                                ]).createShader(Rect.fromLTRB(
                                0, -140, rect.width, rect.height * 0.8));
                          },
                          blendMode: BlendMode.darken,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: ExactAssetImage(coverImage),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        header,
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: ColorTheme.primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                                color: ColorTheme.backgroundDarker,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05,
                                  right:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                child: body,
                              )),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
