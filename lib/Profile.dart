import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thepondapp/Dashboard.dart';
import 'package:thepondapp/widgets/SnowbankContainer.dart';
import 'package:thepondapp/widgets/UserAvatar.dart';
import 'package:thepondapp/auth.dart';

class Profile extends StatefulWidget {
  Profile({Key key, this.user}) : super(key: key);

  final User user;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // State variables
  bool emailIsVerified = emailVerified();
  bool emailVerificationSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Container(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return Dashboard();
              }));
            },
            child: Image(
              height: 45,
              image: AssetImage(
                'assets/images/logo/THEPOND_RGB_WHITE_WORDMARK_RAW.png',
              ),
            ),
          ),
        ),
        actions: [
          Container(
            height: 50,
            width: 60,
            padding: EdgeInsets.all(5),
            child: InkWell(
              child: Icon(
                Icons.settings,
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
      body: SnowbankContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      padding: EdgeInsets.only(top: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Display Name',
                                    ),
                                    initialValue: widget.user.displayName,
                                    keyboardType: TextInputType.text,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Please enter your display name';
                                      }

                                      return null;
                                    },
                                    onFieldSubmitted: (value) {
                                      widget.user.updateProfile(
                                        displayName: value,
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          enabled: false,
                                          initialValue: widget.user.email,
                                          decoration: InputDecoration(
                                            labelText: 'Email',
                                            disabledBorder: InputBorder.none,
                                          ),
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: !emailVerificationSent
                                            ? Container(
                                                child: emailIsVerified
                                                    ? FlatButton(
                                                        onPressed: null,
                                                        child: Text(
                                                          'verified',
                                                          style: TextStyle(
                                                            color: Colors.green,
                                                          ),
                                                        ),
                                                      )
                                                    : FlatButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            emailVerificationSent =
                                                                true;
                                                          });

                                                          await widget.user
                                                              .sendEmailVerification()
                                                              .then((_) {
                                                            var timesChecked =
                                                                0;
                                                            return Timer
                                                                .periodic(
                                                                    Duration(
                                                                        seconds:
                                                                            5),
                                                                    (timer) {
                                                              timesChecked++;

                                                              if (emailVerified()) {
                                                                setState(() {
                                                                  emailIsVerified =
                                                                      widget
                                                                          .user
                                                                          .emailVerified;
                                                                  emailVerificationSent =
                                                                      false;

                                                                  timer
                                                                      .cancel();
                                                                });
                                                              } else if (timesChecked >=
                                                                  5) {
                                                                timer.cancel();
                                                              }
                                                            });
                                                          });
                                                        },
                                                        color: Color.fromARGB(
                                                            255, 225, 225, 225),
                                                        child: Text(
                                                          'verify',
                                                        ),
                                                      ),
                                              )
                                            : Container(
                                                child: FlatButton(
                                                  onPressed: null,
                                                  child: Text(
                                                    'sent',
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FractionalTranslation(
                  translation: Offset(0.0, 0.2),
                  child: Align(
                    child: SizedBox(
                      height: 140,
                      child: UserAvatar(),
                    ),
                    alignment: FractionalOffset(0.5, 0.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
