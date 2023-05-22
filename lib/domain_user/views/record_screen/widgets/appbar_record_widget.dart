import 'package:flutter/material.dart';
import 'package:musix/theme/theme.dart';

class AppBarRecordWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Widget? actionWidget;
  const AppBarRecordWidget({
    required this.title,
    this.actionWidget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.maybePop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_sharp,
          color: Colors.white,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyleTheme.ts20.copyWith(
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
      actions: [
        actionWidget ?? const SizedBox.shrink(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
