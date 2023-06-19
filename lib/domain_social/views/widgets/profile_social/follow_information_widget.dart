import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_social/views/screens/list_follow_screen.dart';
import 'package:musix/domain_user/utils/convert_model_entity.dart';
import 'package:musix/routing/routing_path.dart';

import '../../../../domain_user/entities/entities.dart';
import '../../../../theme/theme.dart';

class FollowInformationWidget extends StatelessWidget {
  const FollowInformationWidget({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    Future<User> getUserInformation(String userId) async {
      final String token = context.read<AuthBloc>().state.jwtToken!;

      final profileRepo = GetIt.I.get<ProfileRepo>();
      final profileResponseModel =
          await profileRepo.getOtherProfile(token, userId);
      return convertUserModelToUser(profileResponseModel.user!);
    }

    return FutureBuilder<User>(
        future: getUserInformation(user.id!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: snapshot.data!.followings!.isNotEmpty
                          ? () => Navigator.pushNamed(
                                context,
                                RoutingPath.listFollowScreen,
                                arguments: ListFollowScreenArgument(
                                    users: snapshot.data!.followings ?? [],
                                    title: "Followings"),
                              )
                          : null,
                      child: Text(
                        '${snapshot.data!.followings?.length}',
                        style: TextStyleTheme.ts14.copyWith(
                          color: snapshot.data!.followings!.isNotEmpty
                              ? Colors.white
                              : Colors.white.withOpacity(.2),
                        ),
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
                    GestureDetector(
                      onTap: snapshot.data!.followers!.isNotEmpty
                          ? () => Navigator.pushNamed(
                                context,
                                RoutingPath.listFollowScreen,
                                arguments: ListFollowScreenArgument(
                                    users: snapshot.data!.followers ?? [],
                                    title: "Followers"),
                              )
                          : null,
                      child: Text(
                        '${snapshot.data!.followers?.length}',
                        style: TextStyleTheme.ts14.copyWith(
                          color: snapshot.data!.followers!.isNotEmpty
                              ? Colors.white
                              : Colors.white.withOpacity(.2),
                        ),
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
