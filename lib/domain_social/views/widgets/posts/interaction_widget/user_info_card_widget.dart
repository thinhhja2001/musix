import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter/repo_exporter.dart';
import 'package:musix/config/exporter/state_exporter.dart';
import 'package:musix/domain_social/entities/entities.dart';
import 'package:musix/domain_user/entities/user.dart';
import 'package:musix/domain_user/utils/constant_utils.dart';
import 'package:musix/domain_user/utils/convert_model_entity.dart';
import 'package:musix/routing/routing_path.dart';

import '../../../../../config/exporter/bloc_exporter.dart';
import '../../../../../domain_auth/views/widgets/custom_button_widget.dart';
import '../../../../../theme/theme.dart';

class UserInfoCardWidget extends StatelessWidget {
  const UserInfoCardWidget({
    super.key,
    required this.userId,
  });
  final String userId;
  @override
  Widget build(BuildContext context) {
    Future<User> getUser(String userId) async {
      String token = context.read<AuthBloc>().state.jwtToken!;
      final userModel = await ProfileRepo().getOtherProfile(token, userId);
      final user = convertUserModelToUser(userModel.user!);
      return user;
    }

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return FutureBuilder<User>(
            future: getUser(userId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final user = snapshot.data;
                return InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, RoutingPath.profileSocial,
                      arguments: user),
                  child: Row(children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          user!.profile?.avatarUrl ?? defaultAvatarUrl),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        user.username ?? "",
                        style: const TextStyle(color: ColorTheme.white),
                      ),
                    ),
                    const Spacer(),
                    state.user!.username != user.username
                        ? Row(
                            children: [
                              CustomButtonWidget(
                                width: 100,
                                height: 40,
                                backgroundColor:
                                    state.user!.followings!.contains(
                                  User(id: user.id, profile: user.profile),
                                )
                                        ? ColorTheme.background
                                        : ColorTheme.primary,
                                onPress: () {
                                  context
                                      .read<ProfileBloc>()
                                      .add(FollowUserProfileEvent(user.id!));
                                },
                                content: state.user!.followings!.contains(
                                  User(id: user.id, profile: user.profile),
                                )
                                    ? "Following\t✓"
                                    : "Follow",
                              ),
                            ],
                          )
                        : const SizedBox()
                  ]),
                );
              }
              return Container();
            });
      },
    );
  }
}
