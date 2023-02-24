import 'package:flutter/material.dart';

import '../../../global/widgets/widgets.dart';
import '../../../routing/routing_path.dart';
import '../../entities/entities.dart';
import '../widgets.dart';

class HubListWidget extends StatelessWidget {
  final String title;
  final List<Hub?> hubs;
  const HubListWidget({
    Key? key,
    required this.title,
    required this.hubs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          RotatedTextWidget(text: title),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: SizedBox(
              height: 240,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: hubs.length,
                itemBuilder: (context, index) {
                  return HubCardWidget(
                    hub: hubs[index],
                    index: index,
                    onPress: () {
                      Navigator.of(context).pushNamed(
                        RoutingPath.playlistList,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
