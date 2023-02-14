import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SkipToNextButtonWidget extends StatelessWidget {
  const SkipToNextButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.skip_next_rounded,
        color: Colors.white,
      ),
    );
  }
}
