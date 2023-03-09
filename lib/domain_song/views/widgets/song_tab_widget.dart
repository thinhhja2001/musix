import 'package:flutter/material.dart';

import '../../../domain_hub/entities/entities.dart';
import '../../../theme/text_style.dart';
import '../../../theme/theme.dart';
import '../widgets.dart';

class SongTabWidget extends StatelessWidget {
  final List<SectionSong> items;
  const SongTabWidget({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty == true) {
      return const SizedBox.shrink();
    }
    return DefaultTabController(
      length: items.length,
      child: SizedBox(
        height: 500,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            RotatedBox(
              quarterTurns: -1,
              child: TabBar(
                indicatorColor: ColorTheme.primary,
                tabs: <Tab>[
                  ...List.generate(
                    items.length,
                    (index) => Tab(
                      child: Text(
                        items[index].title!,
                        style: TextStyleTheme.ts20.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ...List.generate(
                    items.length,
                    (index) => SizedBox(
                      child: SongListWidget(
                        sectionSong: items[index],
                        songArrange: SongArrange.info,
                        isShowTitle: false,
                        isScrollable: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
