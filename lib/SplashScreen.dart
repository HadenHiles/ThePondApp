import 'package:flutter/material.dart';
import 'package:custom_splash/custom_splash.dart';
import 'Login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSplash(
      imagePath: 'assets/images/logo/THEPOND_WHITE_SNOWBANK.png',
      backGroundColor: Color.fromARGB(255, 20, 52, 90),
      animationEffect: 'fade-in',
      duration: 1500,
      logoSize: 350,
      type: CustomSplashType.StaticDuration,
      home: Login(),
    );
  }
}
