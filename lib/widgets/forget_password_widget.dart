import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
        height: screenSize.height * 0.7, child: forgetPassword(context));
  }

  Widget forgetPassword(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final TextEditingController _email = TextEditingController();
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "DM Sans",
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  Container(
                    child: const Text(
                      "Enter the email associated with your account and we???ll send an email instruction to reset your password.",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.03,
            ),
            const Text(
              "Email Address",
              style: TextStyle(
                color: Color.fromRGBO(143, 143, 143, 1),
                fontFamily: "Roboto",
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                color: const Color.fromRGBO(49, 62, 85, 1),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ThemeData().colorScheme.copyWith(
                          primary: const Color.fromRGBO(31, 223, 100, 1),
                        ),
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _email,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      focusColor: Color.fromRGBO(31, 223, 100, 1),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(31, 223, 100, 1), width: 3.0),
                      ),
                      hintText: 'Email address',
                      hintStyle:
                          TextStyle(color: Color.fromRGBO(89, 89, 89, 1)),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                        return "Email invalidated";
                      } else {
                        return null;
                      }
                    },
                  ),
                )),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            SizedBox(
              width: screenSize.width,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(31, 223, 100, 1)),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    auth.sendPasswordResetEmail(email: _email.text);
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                      msg:
                          "A mail have just been sent to your email\n Please check your email to reset your password!",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                },
                child: const Text(
                  "Request reset password link",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: screenSize.width,
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Color.fromRGBO(31, 223, 100, 1),
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
