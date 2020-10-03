import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:thepondapp/Dashboard.dart';
import 'package:thepondapp/SignIn.dart';
import 'package:password_strength/password_strength.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Auth variables
  FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;

  // static form variables
  final _signInFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final _authCodeFormKey = GlobalKey<FormState>();

  // State variables
  bool validCode = false;
  bool _signedIn = FirebaseAuth.instance.currentUser != null;

  @override
  Widget build(BuildContext context) {
    //If user is signed in
    if (_signedIn) {
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
                height: 250,
                width: 340,
                image:
                    AssetImage('assets/images/logo/THEPOND_WHITE_SNOWBANK.png'),
              ),
              SignInButton(
                Buttons.Google,
                onPressed: () {
                  socialSignIn(context, 'google', (error) {
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
                  socialSignIn(context, 'facebook', (error) {
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
              SizedBox(
                width: 220,
                child: Divider(
                  height: 30,
                  indent: 40,
                  endIndent: 40,
                  thickness: 1,
                  color: Color.fromARGB(75, 255, 255, 255),
                ),
              ),
              SizedBox(
                width: 220.0,
                child: RaisedButton(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                        height: 30,
                        image: AssetImage(
                          'assets/images/logo/THEPOND_RGB_WORDMARK_RAW.png',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text('Sign in with Email'),
                      ),
                    ],
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      height: 50,
                                      image: AssetImage(
                                        'assets/images/logo/THEPOND_RGB_WORDMARK_RAW.png',
                                      ),
                                    ),
                                    Text(
                                      'SIGN IN',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                Form(
                                  key: _signInFormKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Email',
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return 'Please enter your email';
                                            } else if (!validEmail(value)) {
                                              return 'Invalid email address';
                                            }

                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            labelText: 'Password',
                                          ),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return 'Please enter a password';
                                            } else if (!validPassword(value)) {
                                              return 'Please enter a stronger password';
                                            }

                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: RaisedButton(
                                            color:
                                                Theme.of(context).primaryColor,
                                            textColor: Colors.white,
                                            child: Text("Sign up"),
                                            onPressed: () {
                                              if (_signInFormKey.currentState
                                                  .validate()) {
                                                _signInFormKey.currentState
                                                    .save();
                                                setState(() {
                                                  _signedIn = true;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              FlatButton(
                color: Colors.transparent,
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    height: 50,
                                    image: AssetImage(
                                      'assets/images/logo/THEPOND_RGB_WORDMARK_RAW.png',
                                    ),
                                  ),
                                  Text(
                                    'SIGN UP',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Form(
                                key: _signUpFormKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'Please enter your email';
                                          }
                                          if (!validEmail(value)) {
                                            return 'Invalid email address';
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: _pass,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                        ),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'Please enter a password';
                                          } else if (!validPassword(value)) {
                                            return 'Please enter a stronger password';
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: _confirmPass,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Confirm Password',
                                        ),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'Please confirm your password';
                                          } else if (value != _pass.text) {
                                            return 'Passwords do not match';
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: RaisedButton(
                                          color: Theme.of(context).primaryColor,
                                          textColor: Colors.white,
                                          child: Text("Sign Up"),
                                          onPressed: () {
                                            if (_signUpFormKey.currentState
                                                .validate()) {
                                              _signUpFormKey.currentState
                                                  .save();

                                              verifyEmail().then((_) {
                                                setState(() {
                                                  _signedIn = true;
                                                });
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool validPassword(String pass) {
    return estimatePasswordStrength(pass) > 0.7;
  }

  Future<void> verifyEmail() async {
    if (!user.emailVerified) {
      await user.sendEmailVerification();
      return AlertDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              height: 150,
              image: AssetImage(
                'assets/images/logo/THEPOND_RGB_WORDMARK_RAW.png',
              ),
            ),
            Text('A verification code has been sent to ${user.email}'),
            Form(
              key: _authCodeFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Code',
                        labelText: 'Authentication Code',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter the code';
                        }

                        if (!validCode) {
                          return 'Invalid code';
                        }

                        return null;
                      },
                      onChanged: (code) async {
                        if (code.length >= 7) {
                          try {
                            await auth.checkActionCode(code);
                            await auth.applyActionCode(code);

                            if (_authCodeFormKey.currentState.validate()) {
                              // If successful, reload the user:
                              auth.currentUser.reload();
                              setState(() {
                                validCode = true;
                              });

                              _authCodeFormKey.currentState.save();
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'invalid-action-code') {
                              setState(() {
                                validCode = false;
                              });
                            }
                          }
                        }
                        _authCodeFormKey.currentState.save();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  signUp(BuildContext context, AuthAttempt authAttempt, Function error) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: authAttempt.email,
        password: authAttempt.password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print(e.toString());
        error('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print(e.toString());
        error('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
      error('There was an error signing up.');
    }
  }

  socialSignIn(BuildContext context, String provider, Function error) {
    if (provider == 'google') {
      signInWithGoogle().then((credential) {
        setState(() {
          _signedIn = true;
        });
      }).catchError((e) {
        var message = "There was an error signing in with Google";
        if (e.code == "user-disabled") {
          message = "Your account has been disabled by the administrator";
        } else if (e.code == "account-exists-with-different-credential") {
          message =
              "An account already exists with the same email address but different sign-in credentials. Please try signing in a different way";
        }

        print(e);
        error(message);
      });
    } else if (provider == 'facebook') {
      signInWithFacebook().then((credential) {
        setState(() {
          _signedIn = true;
        });
      }).catchError((e) {
        var message = "There was an error signing in with Facebook";
        if (e.code == "user-disabled") {
          message = "Your account has been disabled by the administrator";
        } else if (e.code == "account-exists-with-different-credential") {
          message =
              "An account already exists with the same email address but different sign-in credentials. Please try signing in a different way";
        }

        print(e);
        error(message);
      });
    }
  }
}

class AuthAttempt {
  final String email;
  final String password;

  AuthAttempt(this.email, this.password);
}
