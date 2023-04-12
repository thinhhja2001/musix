import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';

class PostActionWidget extends StatelessWidget {
  const PostActionWidget({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });
  final String text;
  final IconData icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: ColorTheme.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyleTheme.ts18.copyWith(
                  fontWeight: FontWeight.bold, color: ColorTheme.white),
            ),
          ],
        ),
      ),
    );
  }
}
