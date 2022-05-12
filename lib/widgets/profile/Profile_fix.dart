import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musix/models/users.dart';
import 'package:musix/resources/auth_methods.dart';
import 'package:musix/utils/colors.dart';
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
    _controller = new TextEditingController(text: widget.user.username);
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

  void AfterSave() {
    user = new Users(email: widget.user.email, username: _controller!.text, uid: widget.user.uid, followers: widget.user.followers, following: widget.user.following, avatarUrl: imageURL!);
    Restart.restartApp();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColorDarker,
        elevation: 0,
        centerTitle: true,
        title: Text("Profile Setting"),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                AuthMethods().setUserProfile(widget.user,
                    image, _controller!.text,imageURL!).then((value) => AfterSave());
                
              },
              child: Text(
                "Save",
                style: TextStyle(
                    fontSize: 18,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w400),
              )),
        ],
      ),
      body: Column(children: [
        SizedBox(
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
            child: Text(
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
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
            decoration: InputDecoration(),
          ),
        ),
      ]),
    );
  }
}
