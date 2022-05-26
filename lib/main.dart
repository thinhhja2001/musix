import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/firebase_options.dart';
import 'package:musix/providers/album_provider.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/providers/email_verification_provider.dart';
import 'package:musix/providers/google_sign_in.dart';
import 'package:musix/providers/sign_in_provider.dart';
import 'package:musix/providers/sign_up_provider.dart';
import 'package:musix/screens/email_verification_screen.dart';
import 'package:musix/screens/home_screen.dart';
import 'package:musix/screens/onboarding_screen.dart';
import 'package:musix/screens/signin_screen.dart';
import 'package:musix/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GoogleSignInProvider>(
          create: (context) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider<EmailVerificationProvider>(
            create: (context) => EmailVerificationProvider()),
        ChangeNotifierProvider<SignInProvider>(
            create: (context) => SignInProvider()),
        ChangeNotifierProvider<SignUpProvider>(
            create: (context) => SignUpProvider()),
        ChangeNotifierProvider<AudioPlayerProvider>(
            create: (context) => AudioPlayerProvider()),
        ChangeNotifierProvider<AlbumProvider>(
          create: (context) => AlbumProvider(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          scaffoldBackgroundColor: const Color(0x000318b5),
        ),
        home: FirebaseAuth.instance.currentUser == null
            ? const OnBoardingScreen()
            : const HomeScreen(),
        routes: <String, WidgetBuilder>{
          "/signin": (context) => const SignInScreen(),
          "/signup": (context) => const SignUpScreen(),
          "/onboarding": (context) => const OnBoardingScreen(),
          "/emailverification": (context) => EmailVerificationScreen(),
          "/home": (context) => const HomeScreen(),
        },
      ),
    );
  }
}
