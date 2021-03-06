import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.onPress,
      required this.content,
      required this.isLoading})
      : super(key: key);
  final VoidCallback onPress;
  final String content;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
          onPressed: onPress,
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  content,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )))),
    );
  }
}
