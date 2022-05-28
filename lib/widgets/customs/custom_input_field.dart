import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';

import '../../utils/enums.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    Key? key,
    required this.customInputFieldType,
    required this.label,
    required this.controller,
  }) : super(key: key);
  final CustomInputFieldType customInputFieldType;
  final String label;
  final TextEditingController controller;
  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  _CustomInputFieldState();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Color.fromARGB(100, 49, 62, 85),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TextFormField(
            cursorColor: kPrimaryColor,
            controller: widget.controller,
            obscureText:
                widget.customInputFieldType == CustomInputFieldType.password
                    ? _isObscure
                    : false,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              suffixIcon: widget.customInputFieldType ==
                      CustomInputFieldType.password
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                      ))
                  : null,
              border: InputBorder.none,
              labelText: widget.label,
              labelStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(48, 255, 255, 255)),
            ),
          ),
        ),
      ),
    );
  }
}
