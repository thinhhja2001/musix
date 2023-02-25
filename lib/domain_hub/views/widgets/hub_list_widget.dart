import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/exporter.dart';
import '../../../global/widgets/widgets.dart';
import '../../../routing/routing_path.dart';
import '../../entities/entities.dart';
import '../widgets.dart';

class HubListWidget extends StatelessWidget {
  final String title;
  final List<Hub> hubs;
  const HubListWidget({
    Key? key,
    required this.title,
    required this.hubs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstHubs = hubs.getRange(0, ((hubs.length ~/ 2) - 1)).toList();
    final secondHubs = hubs.getRange((hubs.length ~/ 2), hubs.length).toList();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          RotatedTextWidget(text: title),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HubCarouselWidget(
                  hubs: firstHubs,
                ),
                const SizedBox(
                  height: 16,
                ),
                HubCarouselWidget(
                  hubs: secondHubs,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HubCarouselWidget extends StatelessWidget {
  final List<Hub> hubs;
  const HubCarouselWidget({
    super.key,
    required this.hubs,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CarouselSlider(
            items: List.generate(
              hubs.length,
              (index) => HubCardWidget(
                hub: hubs[index],
                onPress: () {
                  context
                      .read<HubBloc>()
                      .add(HubGetInfoEvent(hubs[index].encodeId!));
                  Navigator.pushNamed(context, RoutingPath.hubInfo);
                },
              ),
            ),
            options: CarouselOptions(
              height: 160,
              autoPlay: true,
              enlargeCenterPage: true,
              enlargeFactor: 0.32,
              aspectRatio: 1,
              viewportFraction: 0.64,
              autoPlayAnimationDuration: const Duration(milliseconds: 1500),
            ),
          ),
        ),
      ],
    );
  }
}
