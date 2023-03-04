import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class VideoSearchBarWidget extends StatelessWidget {
  VideoSearchBarWidget({super.key});
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorTheme.bottomNavigationBar,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                color: ColorTheme.background,
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      style: TextStyleTheme.ts15.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration.collapsed(
                          hintText: r'What do you want to hear?',
                          hintStyle: TextStyleTheme.ts15.copyWith(
                            color: ColorTheme.grey100,
                            fontWeight: FontWeight.w400,
                          ),
                          fillColor: ColorTheme.primary),
                      cursorColor: ColorTheme.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      textEditingController.clear();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorTheme.primaryLighten,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: ColorTheme.backgroundDarker,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
