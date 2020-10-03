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
  final TextEditingController _signInEmail = TextEditingController();
  final TextEditingController _signInPass = TextEditingController();
  final TextEditingController _signUpEmail = TextEditingController();
  final TextEditingController _signUpPass = TextEditingController();
  final TextEditingController _signUpConfirmPass = TextEditingController();

  // State variables
  bool signedIn = FirebaseAuth.instance.currentUser != null;

  @override
  Widget build(BuildContext context) {
    //If user is signed in
    if (signedIn) {
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
                    _scaffoldKey.currentState.hideCurrentSnackBar();
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
                    _scaffoldKey.currentState.hideCurrentSnackBar();
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
                        return SimpleDialog(
                          contentPadding: EdgeInsets.all(25),
                          children: [
                            SingleChildScrollView(
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
                                            controller: _signInEmail,
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
                                            controller: _signInPass,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              labelText: 'Password',
                                            ),
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return 'Please enter a password';
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
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              textColor: Colors.white,
                                              child: Text("Sign in"),
                                              onPressed: () {
                                                if (_signInFormKey.currentState
                                                    .validate()) {
                                                  _signInFormKey.currentState
                                                      .save();

                                                  signIn(
                                                      context,
                                                      AuthAttempt(
                                                        _signInEmail.text,
                                                        _signInPass.text,
                                                      ), (error) {
                                                    _scaffoldKey.currentState
                                                        .hideCurrentSnackBar();
                                                    _scaffoldKey.currentState
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(error),
                                                        duration: Duration(
                                                            seconds: 10),
                                                        action: SnackBarAction(
                                                          label: "Dismiss",
                                                          onPressed: () {
                                                            _scaffoldKey
                                                                .currentState
                                                                .hideCurrentSnackBar();
                                                          },
                                                        ),
                                                      ),
                                                    );
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
                          ],
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
                      return SimpleDialog(
                        contentPadding: EdgeInsets.all(25),
                        children: [
                          SingleChildScrollView(
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
                                          controller: _signUpEmail,
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
                                          controller: _signUpPass,
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
                                          controller: _signUpConfirmPass,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            labelText: 'Confirm Password',
                                          ),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return 'Please confirm your password';
                                            } else if (value !=
                                                _signUpPass.text) {
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
                                            color:
                                                Theme.of(context).primaryColor,
                                            textColor: Colors.white,
                                            child: Text("Sign up"),
                                            onPressed: () {
                                              if (_signUpFormKey.currentState
                                                  .validate()) {
                                                _signUpFormKey.currentState
                                                    .save();

                                                signUp(
                                                    context,
                                                    AuthAttempt(
                                                      _signUpEmail.text,
                                                      _signUpPass.text,
                                                    ), (error) {
                                                  _scaffoldKey.currentState
                                                      .hideCurrentSnackBar();
                                                  _scaffoldKey.currentState
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(error),
                                                      duration:
                                                          Duration(seconds: 10),
                                                      action: SnackBarAction(
                                                        label: "Dismiss",
                                                        onPressed: () {
                                                          _scaffoldKey
                                                              .currentState
                                                              .hideCurrentSnackBar();
                                                        },
                                                      ),
                                                    ),
                                                  );
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
                        ],
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

  signUp(BuildContext context, AuthAttempt authAttempt, Function error) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: authAttempt.email,
        password: authAttempt.password,
      )
          .then((_) {
        Navigator.of(context, rootNavigator: true).pop('dialog');

        setState(() {
          signedIn = true;
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print(e.toString());
        await error('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print(e.toString());
        await error('The account already exists for that email');
      } else {
        print(e.toString());
        await error('There was an error signing up');
      }
    } catch (e) {
      print(e.toString());
      await error('There was an error signing up');
    }
  }

  signIn(BuildContext context, AuthAttempt authAttempt, Function error) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: authAttempt.email,
        password: authAttempt.password,
      )
          .then((_) {
        Navigator.of(context, rootNavigator: true).pop('dialog');

        setState(() {
          signedIn = true;
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print(e.toString());
        await error('No user found for that email');
      } else if (e.code == 'wrong-password') {
        print(e.toString());
        await error('Wrong password');
      } else {
        print(e.toString());
        await error('There was an error signing in');
      }
    } catch (e) {
      print(e.toString());
      await error('There was an error signing in');
    }
  }

  socialSignIn(BuildContext context, String provider, Function error) async {
    if (provider == 'google') {
      signInWithGoogle().then((credential) {
        setState(() {
          signedIn = true;
        });
      }).catchError((e) async {
        var message = "There was an error signing in with Google";
        if (e.code == "user-disabled") {
          message = "Your account has been disabled by the administrator";
        } else if (e.code == "account-exists-with-different-credential") {
          message =
              "An account already exists with the same email address but different sign-in credentials. Please try signing in a different way";
        }

        print(e);
        await error(message);
      });
    } else if (provider == 'facebook') {
      signInWithFacebook().then((credential) {
        setState(() {
          signedIn = true;
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
