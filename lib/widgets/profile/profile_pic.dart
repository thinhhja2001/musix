import 'dart:io';

import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
    required this.avatarUrl,
    this.OnTap,
    this.imagePicker,
  }) : super(key: key);

  final String avatarUrl;
  final Function? OnTap;
  final File? imagePicker;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        children: [
          imagePicker != null
              ? CircleAvatar(
                  child: Image.file(imagePicker!),
                )
              : avatarUrl == ""
                  ? CircleAvatar(
                      child: Icon(Icons.photo_camera),
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(avatarUrl),
                    ),
        ],
      ),
    );
  }
}
