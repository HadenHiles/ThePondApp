import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:thepondapp/Dashboard.dart';
import 'package:thepondapp/SignIn.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return Dashboard();
    }

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              height: 250,
              image: AssetImage('assets/images/logo/THEPOND_RGB_SNOWBANK.png'),
            ),
            SignInButton(Buttons.Google, onPressed: () {
              signInWithGoogle().then((credential) {
                if (credential.user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return Dashboard();
                      },
                    ),
                  );
                }
              });
            }),
            SignInButton(
              Buttons.Facebook,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
