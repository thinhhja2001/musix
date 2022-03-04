import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPress,
    required this.content,
  }) : super(key: key);
  final VoidCallback onPress;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kButtonMarginTop * 2, bottom: 10),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
            onPressed: onPress,
            child: Text(
              content,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(kPrimaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )))),
      ),
    );
  }
}
