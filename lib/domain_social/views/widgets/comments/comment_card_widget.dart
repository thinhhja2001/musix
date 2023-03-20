import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class CommentCardWidget extends StatelessWidget {
  const CommentCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
              radius: 10,
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "thinhhja201 · 3 months ago",
                    style: TextStyleTheme.ts12
                        .copyWith(color: ColorTheme.white.withOpacity(.7)),
                  ),
                  Text(
                    "the best song I've ever heard",
                    style: TextStyleTheme.ts12.copyWith(
                      color: ColorTheme.white,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.thumb_up_alt,
                        color: ColorTheme.white,
                        size: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "50",
                          style: TextStyleTheme.ts10
                              .copyWith(color: ColorTheme.white),
                        ),
                      ),
                      const Icon(
                        Icons.thumb_down_off_alt_outlined,
                        color: ColorTheme.white,
                        size: 10,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Icons.comment_outlined,
                        size: 10,
                        color: ColorTheme.white,
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor: MaterialStatePropertyAll(
                        ColorTheme.primary.withOpacity(.2),
                      ),
                    ),
                    child: Text(
                      "15 replies",
                      style: TextStyleTheme.ts14
                          .copyWith(color: ColorTheme.primary),
                    ),
                  )
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
