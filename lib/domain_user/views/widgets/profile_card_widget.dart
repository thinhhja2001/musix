import 'package:flutter/material.dart';
import 'package:musix/routing/routing_path.dart';

import '../../../utils/utils.dart';

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({Key? key}) : super(key: key);

  final String userName = 'Nguyen Van A';
  final String avatar = AssetPath.signInCover;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
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
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
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
      ),
    );
  }
}
