import 'package:flutter/material.dart';

import '../../../global/widgets/custom_card_widget.dart';
import '../../../theme/theme.dart';
import '../../entities/entities.dart';

class HubCardWidget extends StatelessWidget {
  final double? size;
  final Hub hub;
  final VoidCallback? onPress;

  const HubCardWidget({
    super.key,
    this.size,
    required this.hub,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      width: size ?? 240,
      height: size ?? 240,
      image: hub.cover!,
      title: hub.title!,
      onTap: onPress,
      titleTextStyle: TextStyleTheme.ts15.copyWith(
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
