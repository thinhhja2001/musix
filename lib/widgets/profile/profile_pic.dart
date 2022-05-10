import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,required this.avatarUrl, this.OnTap,
  }) : super(key: key);

  final String avatarUrl;
  final Function? OnTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        children: [
          avatarUrl == ""
              ? CircleAvatar(
                  child: Icon(Icons.photo_camera),
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(avatarUrl),
                ),
          // Positioned(
          //   right: 5,
          //   bottom: 0,
          //   child: SizedBox(
          //     height: 46,
          //     width: 46,
          //     child: DecoratedBox(
          //         decoration: BoxDecoration(
          //           color: Colors.black,
          //           borderRadius: BorderRadius.circular(100),
          //         ),
          //         child: IconButton(
          //           icon: const Icon(
          //             Icons.camera_alt,
          //             color: Colors.white,
          //           ),
          //           onPressed: () {},
          //         )),
          //   ),
          // )
        ],
      ),
    );
  }
}
