import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SkipToPreviousButtonWidget extends StatelessWidget {
  const SkipToPreviousButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.skip_previous_rounded,
        color: Colors.white,
        size: 25,
      ),
    );
  }
}
