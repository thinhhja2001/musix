import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/theme.dart';
import 'hashtag_widget.dart';
import 'interaction_widget.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 450,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: ColorTheme.primary,
                borderRadius: BorderRadius.circular(20)),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                            width: double.infinity,
                            placeholder: (context, url) => Shimmer.fromColors(
                                  baseColor: ColorTheme.background,
                                  highlightColor: ColorTheme.backgroundDarker,
                                  child: const Material(
                                    color: Colors.white,
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 240,
                                    ),
                                  ),
                                ),
                            fit: BoxFit.fill,
                            imageUrl:
                                "https://images.unsplash.com/reserve/Af0sF2OS5S5gatqrKzVP_Silhoutte.jpg?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Thinhhja2001',
                                    style: TextStyleTheme.ts18.copyWith(
                                        color: ColorTheme.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "40 min ago",
                                    style: TextStyleTheme.ts14.copyWith(
                                      color: ColorTheme.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Title
                        Text(
                          "This is the moment where i take a photo of a couple hugging in a beautiful rice field.",
                          maxLines: 2,
                          style: TextStyleTheme.ts16
                              .copyWith(color: ColorTheme.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const HashtagWidget(),
                        const Spacer(),
                        const InteractionListWidget(),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
