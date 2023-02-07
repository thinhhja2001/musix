import 'package:flutter/material.dart';
import 'package:musix/routing/routing_path.dart';
import 'package:musix/theme/text_style.dart';

import '../../../utils/utils.dart';

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({Key? key}) : super(key: key);

  final String userName = 'Nguyen Van A';
  final String avatar = AssetPath.signInCover;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutingPath.profile);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.36),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userName,
                style: TextStyleTheme.ts20.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
                // style: const TextStyle(
                //     color: Colors.white,
                //     fontSize: F,
                //     fontWeight: FontWeight.w400),
              ),
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  avatar,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
