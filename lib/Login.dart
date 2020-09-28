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

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
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
                  _signIn(context, 'google', (error) {
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text(error),
                        duration: Duration(seconds: 10),
                        action: SnackBarAction(
                          label: "Dismiss",
                          onPressed: () {
                            _scaffoldKey.currentState.hideCurrentSnackBar();
                          },
                        ),
                      ),
                    );
                  });
                },
              ),
              SignInButton(
                Buttons.Facebook,
                onPressed: () {
                  _signIn(context, 'facebook', (error) {
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text(error),
                        duration: Duration(seconds: 10),
                        action: SnackBarAction(
                          label: "Dismiss",
                          onPressed: () {
                            _scaffoldKey.currentState.hideCurrentSnackBar();
                          },
                        ),
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signIn(BuildContext context, String provider, Function error) {
    if (provider == 'google') {
      signInWithGoogle().then((credential) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return Dashboard();
            },
          ),
        );
      }).catchError((e) {
        var message = "There was an error signing in with Google";
        if (e.code == "user-disabled") {
          message = "Your account has been disabled by the administrator";
        }

        print(e);
        error(message);
      });
    } else if (provider == 'facebook') {
      signInWithFacebook().then((credential) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return Dashboard();
            },
          ),
        );
      }).catchError((e) {
        var message = "There was an error signing in with Facebook";
        if (e.code == "user-disabled") {
          message = "Your account has been disabled by the administrator";
        }

        print(e);
        error(message);
      });
    }
  }
}
