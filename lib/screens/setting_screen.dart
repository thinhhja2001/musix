import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:musix/widgets/profile/user_info.dart';

import '../utils/colors.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xCC000000),
      extendBodyBehindAppBar: true,
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Material(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.black,
            child: Column(
              children: [
                Stack(
                  children: <Widget>[
                    Image(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/profile-img.png"),
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                    ),
                    ClipRRect(
                      // Clip it cleanly.
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.withOpacity(0.1),
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: Icon(Icons.camera_alt),
                            onPressed: () {},
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0x00000000),
                            const Color(0xCC000000),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, bottom: 20, right: 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "James Smith",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "02 Jan 1992",
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 12),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Logout",
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 15),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: kBackgroundColorDarker),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
                UserInfo(
                    username: "Eleventea",
                    email: "19522408@gm.uit.edu.vn",
                    phone: "+84862751020"),
                    
              ],
            ),
          ),
        ),
      ),
    );
  }
}
