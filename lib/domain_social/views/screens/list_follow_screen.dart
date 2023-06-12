import 'package:flutter/material.dart';
import 'package:musix/domain_social/views/widgets/posts/interaction_widget/user_info_card_widget.dart';
import 'package:musix/domain_user/entities/entities.dart';
import 'package:musix/domain_user/utils/constant_utils.dart';
import 'package:musix/theme/color.dart';

class ListFollowScreenArgument {
  final List<User> users;
  final String title;

  ListFollowScreenArgument({required this.users, required this.title});
}

class ListFollowScreen extends StatelessWidget {
  const ListFollowScreen({super.key, required this.listFollowScreenArgument});
  final ListFollowScreenArgument listFollowScreenArgument;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(Icons.arrow_back_ios)),
          centerTitle: true,
          title: Text(listFollowScreenArgument.title),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent),
      backgroundColor: ColorTheme.backgroundDarker,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: listFollowScreenArgument.users.length,
            itemBuilder: (context, index) => UserInfoCardWidget(
                userId: listFollowScreenArgument.users.elementAt(index).id!)),
      ),
    );
  }
}
