
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';


class ModalItem extends StatefulWidget {
  const ModalItem({Key? key, required this.icon, required this.title})
      : super(key: key);

  final IconData icon;
  final String title;
  @override
  State<ModalItem> createState() => _ModalItemState();
}

class _ModalItemState extends State<ModalItem> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Icon(
            widget.icon,
            color: kPrimaryColor,
          ),
        ),
        Text(widget.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
      ],
    );
  }
}
