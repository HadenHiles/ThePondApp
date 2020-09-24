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
              SignInButton(
                Buttons.Google,
                onPressed: () {
                  _googleSignIn(context);
                },
              ),
              SignInButton(
                Buttons.Facebook,
                onPressed: () {
                  _facebookSignIn(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _googleSignIn(context) {
    signInWithGoogle().then((credential) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return Dashboard();
          },
        ),
      );
    });
  }

  _facebookSignIn(context) {
    signInWithFacebook().then((credential) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return Dashboard();
          },
        ),
      );
    }).catchError((e) {
      final _auth = FirebaseAuth.instance;
      // The account already exists with a different credential
      String email = e.email;
      AuthCredential pendingFbCredential = e.credential;

      // Fetch a list of what sign-in methods exist for the conflicting user
      _auth.fetchSignInMethodsForEmail(email).then((userSignInMethods) {
        // Since the user signed in with google first - make them sign in again before linking their facebook account
        if (userSignInMethods.first == 'google.com') {
          signInWithGoogle().then((credential) {
            credential.user
                .linkWithCredential(pendingFbCredential)
                .then((credential) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return Dashboard();
                  },
                ),
              );
            });
          });
        }
      });
    });
  }
}
