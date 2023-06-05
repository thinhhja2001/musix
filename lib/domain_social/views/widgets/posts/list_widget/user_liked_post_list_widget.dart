import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_auth/views/widgets/custom_button_widget.dart';
import 'package:musix/domain_social/entities/post/post.dart';
import 'package:musix/routing/routing_path.dart';
import 'package:musix/theme/color.dart';

import '../../../../../domain_user/entities/entities.dart';
import '../../../../../domain_user/logic/profile_bloc.dart';

class UserLikedPostListWidget extends StatelessWidget {
  const UserLikedPostListWidget({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    final usersLiked = post.likedBy;
    return Container(
      color: ColorTheme.backgroundDarker,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: usersLiked?.length,
        itemBuilder: (context, index) =>
            UserInfoCardWidget(user: post.likedBy!.elementAt(index)),
      ),
    );
  }
}

class UserInfoCardWidget extends StatelessWidget {
  const UserInfoCardWidget({
    super.key,
    required this.user,
  });
  final User user;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => Navigator.pushNamed(context, RoutingPath.profileSocial,
              arguments: user),
          child: Row(children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.profile!.avatarUrl!),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                user.username!,
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
                        backgroundColor: state.user!.followings!.contains(
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
      },
    );
  }
}
