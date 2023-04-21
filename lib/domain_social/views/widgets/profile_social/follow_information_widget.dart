import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_user/utils/convert_model_entity.dart';

import '../../../../domain_user/entities/entities.dart';
import '../../../../theme/theme.dart';

Future<User> _getUserInformation(String userId) async {
  final profileRepo = GetIt.I.get<ProfileRepo>();
  final profileResponseModel =
      await profileRepo.getOtherProfile(testTokenConst, userId);
  return convertUserModelToUser(profileResponseModel.user!);
}

class FollowInformationWidget extends StatelessWidget {
  const FollowInformationWidget({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: _getUserInformation(user.id!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      '${snapshot.data!.followings?.length}',
                      style: TextStyleTheme.ts14.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Following",
                      style: TextStyleTheme.ts12
                          .copyWith(color: const Color(0xff86878B)),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '${snapshot.data!.followers?.length}',
                      style: TextStyleTheme.ts14.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Followers",
                      style: TextStyleTheme.ts12
                          .copyWith(color: const Color(0xff86878B)),
                    )
                  ],
                ),
              ],
            );
          }
          return Container();
        });
  }
}
