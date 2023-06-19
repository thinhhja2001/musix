import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_user/entities/entities.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain_auth/views/widgets/custom_button_widget.dart';
import '../../../../domain_user/entities/profile/profile_state.dart';
import '../../../../domain_user/entities/user.dart';
import '../../../../domain_user/logic/profile_bloc.dart';
import '../../../../theme/theme.dart';

_sendingMails(String email) async {
  var url = Uri.parse("mailto:$email");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class InteractWithUserWidget extends StatelessWidget {
  const InteractWithUserWidget({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.user!.username != user.username) {
          return Row(
            children: [
              Expanded(
                child: CustomButtonWidget(
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
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => _sendingMails(user.email!),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: ColorTheme.background,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey)),
                      child: const Icon(
                        Icons.email_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: ColorTheme.background,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey)),
                    child: const Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ))
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
