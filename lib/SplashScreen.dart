import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:thepondapp/Dashboard.dart';
import 'Login.dart';

final Map<dynamic, Widget> returnValueAndHomeScreen = {
  1: Login(),
  2: Dashboard()
};

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login-bg.jpg'),
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
          colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      child: CustomSplash(
        imagePath: 'assets/images/logo/THEPOND_WHITE_SNOWBANK.png',
        backGroundColor: Color.fromARGB(0, 0, 0, 0),
        duration: 1200,
        logoSize: 750,
        type: CustomSplashType.StaticDuration,
        customFunction: backgroundTask,
        home: Dashboard(),
        outputAndHome: returnValueAndHomeScreen,
      ),
    );
  }

  backgroundTask() {
    if (FirebaseAuth.instance.currentUser != null) {
      return 2;
    }

    return 1;
  }
}
