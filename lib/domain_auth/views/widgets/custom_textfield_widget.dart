import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class CustomInputFieldWidget extends StatefulWidget {
  const CustomInputFieldWidget({
    Key? key,
    required this.textInputType,
    required this.label,
    required this.controller,
    this.validation,
    this.darkTheme = true,
    this.maxLines = 1,
  }) : super(key: key);
  final TextInputType textInputType;
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validation;
  final bool darkTheme;
  final int? maxLines;
  @override
  State<CustomInputFieldWidget> createState() => _CustomInputFieldWidgetState();
}

class _CustomInputFieldWidgetState extends State<CustomInputFieldWidget> {
  _CustomInputFieldWidgetState();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextFormField(
        cursorColor: ColorTheme.primary,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        obscureText: widget.textInputType == TextInputType.visiblePassword
            ? _isObscure
            : false,
        maxLines: widget.maxLines,
        style: TextStyle(
            color: widget.darkTheme ? Colors.white : Colors.black,
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          fillColor: ColorTheme.background,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          errorStyle: TextStyleTheme.ts10.copyWith(
            fontWeight: FontWeight.w400,
            color: Colors.red,
          ),
          suffixIcon: widget.textInputType == TextInputType.visiblePassword
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
          label: Padding(
            padding: const EdgeInsets.only(top: 4, left: 8),
            child: Text(
              widget.label,
              style: TextStyleTheme.ts15.copyWith(
                fontWeight: FontWeight.w400,
                color: widget.darkTheme ? Colors.grey.shade100 : Colors.black54,
              ),
            ),
          ),
        ),
        validator: widget.validation,
      ),
    );
  }
}
