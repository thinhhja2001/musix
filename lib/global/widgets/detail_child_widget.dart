import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class DetailChildWidget extends StatelessWidget {
  const DetailChildWidget({
    required this.icon,
    required this.data,
    required this.onPress,
  });
  final IconData icon;
  final String data;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Row(
        children: [
          Icon(
            icon,
            size: 32,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            data,
            style: TextStyleTheme.ts20.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
