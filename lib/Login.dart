import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:thepondapp/Dashboard.dart';
import 'package:thepondapp/SignIn.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //If user is signed in
    if (FirebaseAuth.instance.currentUser != null) {
      return Dashboard();
    }

    return Scaffold(
      body: Container(
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                height: 290,
                image:
                    AssetImage('assets/images/logo/THEPOND_WHITE_SNOWBANK.png'),
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
                  } else {
                    // There was an issue signing in
                    throw ('Failed to login with Google.');
                  }
                });
              }),
              SignInButton(
                Buttons.Facebook,
                onPressed: () {
                  signInWithFacebook().then((credential) {
                    if (credential.user != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return Dashboard();
                          },
                        ),
                      );
                    } else {
                      // There was an issue signing in
                      throw ('Failed to login with Facebook.');
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
