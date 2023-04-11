import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musix/routing/routing_path.dart';

import '../../../../../domain_user/entities/profile/profile_state.dart';
import '../../../../../domain_user/entities/user.dart';
import '../../../../../domain_user/logic/profile_bloc.dart';
import '../../../../../domain_user/utils/constant_utils.dart';
import '../../../../../theme/theme.dart';

class CreatePostBarWidget extends StatelessWidget {
  const CreatePostBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileBloc, ProfileState, User?>(
      selector: (state) {
        return state.user;
      },
      builder: (context, currentUser) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(RoutingPath.createNewPost);
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    currentUser!.profile!.avatarUrl ?? defaultAvatarUrl),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Any masterpiece you wanna share?",
                      style: TextStyleTheme.ts18.copyWith(
                        color: ColorTheme.white,
                      )),
                ),
              ),
              SvgPicture.asset(
                "assets/images/images/music.svg",
                color: ColorTheme.primary,
                height: 30,
              )
            ],
          ),
        );
      },
    );
  }
}
