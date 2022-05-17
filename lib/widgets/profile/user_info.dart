import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/widgets/profile/info_card.dart';

class UserInfo extends StatelessWidget {
  final String username;
  final String email;
  final String phone;
  const UserInfo(
      {Key? key,
      required this.username,
      required this.email,
      required this.phone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
            ),
          ],
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "User info",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: "SF Pro Text"),
            ),
            const SizedBox(
              height: 30,
            ),
            InfoCard("Username", username),
            const SizedBox(
              height: 20,
            ),
            InfoCard("Email", email),
            const SizedBox(
              height: 20,
            ),
            InfoCard("Phone", phone),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Change password",
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
