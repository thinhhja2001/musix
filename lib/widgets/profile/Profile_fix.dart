import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/widgets/profile/profile_pic.dart';

class FixProfile extends StatefulWidget {
  const FixProfile({Key? key}) : super(key: key);

  @override
  State<FixProfile> createState() => _FixProfileState();
}

class _FixProfileState extends State<FixProfile> {
  TextEditingController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new TextEditingController(text: 'Tea');
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
              onPressed: () {},
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
        ProfilePic(avatarUrl: "",),
        TextButton(
            onPressed: () {},
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
            decoration: InputDecoration(
              
            ),
          ),
        ),
      ]),
    );
  }
}
