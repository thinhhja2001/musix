import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/theme.dart';

class PostShimmerLoadingWidget extends StatelessWidget {
  const PostShimmerLoadingWidget({
    this.padding,
    super.key,
  });
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0.0),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            width: double.infinity,
            height: 150,
            child: Shimmer.fromColors(
                baseColor: ColorTheme.background,
                highlightColor: ColorTheme.backgroundDarker,
                child: Material(
                  color: Colors.white,
                  child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    width: double.infinity,
                    height: 240,
                  ),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                  baseColor: ColorTheme.background,
                  highlightColor: ColorTheme.backgroundDarker,
                  child: const CircleAvatar(
                    radius: 30,
                  )),
              Expanded(
                  child: Column(
                children: [
                  Shimmer.fromColors(
                      baseColor: ColorTheme.background,
                      highlightColor: ColorTheme.backgroundDarker,
                      child: const Material(
                        color: Colors.white,
                        child: SizedBox(
                          width: double.infinity,
                          height: 40,
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Shimmer.fromColors(
                      baseColor: ColorTheme.background,
                      highlightColor: ColorTheme.backgroundDarker,
                      child: const Material(
                        color: Colors.white,
                        child: SizedBox(
                          width: double.infinity,
                          height: 40,
                        ),
                      )),
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
