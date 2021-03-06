import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/models/users.dart';
import 'package:musix/resources/profile_methods.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/utils.dart';
import 'package:musix/widgets/profile/profile_pic.dart';
import 'package:restart_app/restart_app.dart';

class FixProfile extends StatefulWidget {
  const FixProfile({Key? key, required this.user}) : super(key: key);
  final Users user;
  @override
  State<FixProfile> createState() => _FixProfileState();
}

class _FixProfileState extends State<FixProfile> {
  TextEditingController? _controller;
  Users? user;
  File? image;
  String? imageURL;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController(text: widget.user.username);
    imageURL = widget.user.avatarUrl;
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void AfterSave(BuildContext context) {
    user = Users(
        email: widget.user.email,
        username: _controller!.text,
        uid: widget.user.uid,
        followers: widget.user.followers,
        following: widget.user.following,
        avatarUrl: imageURL!);
    showCompleteNotification(
        title: 'User information updated',
        message: 'Please restart the app to see changes',
        icon: MdiIcons.check);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColorDarker,
        elevation: 0,
        centerTitle: true,
        title: const Text("Profile Setting"),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                ProfileMethods()
                    .setUserProfile(
                        widget.user, image, _controller!.text, imageURL!)
                    .then((value) => AfterSave(context));
              },
              child: const Text(
                "Save",
                style: TextStyle(
                    fontSize: 18,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w400),
              )),
        ],
      ),
      body: Column(children: [
        const SizedBox(
          width: double.infinity,
          height: 20,
        ),
        ProfilePic(
          avatarUrl: widget.user.avatarUrl,
          imagePicker: image,
        ),
        TextButton(
            onPressed: () {
              pickImage().then((value) => (setState(() {})));
            },
            child: const Text(
              "Change your avatar",
              style: TextStyle(
                  fontSize: 18,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold),
            )),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            controller: _controller,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
            decoration: const InputDecoration(),
          ),
        ),
      ]),
    );
  }
}
