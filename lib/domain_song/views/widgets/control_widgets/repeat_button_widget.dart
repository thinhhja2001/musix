import 'package:flutter/material.dart';

class RepeatButtonWidget extends StatelessWidget {
  const RepeatButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.repeat,
        color: Colors.white,
      ),
    );
  }
}
