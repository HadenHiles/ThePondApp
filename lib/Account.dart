import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thepondapp/Dashboard.dart';
import 'package:thepondapp/widgets/SnowbankContainer.dart';
import 'package:thepondapp/widgets/UserAvatar.dart';
import 'package:thepondapp/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';

class Account extends StatefulWidget {
  Account({Key key, this.user}) : super(key: key);

  final User user;

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  // State variables
  bool emailIsVerified = emailVerified();
  bool emailVerificationSent = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          child: Image(
            height: 45,
            image: AssetImage(
              'assets/images/logo/THEPOND_RGB_WHITE_WORDMARK_RAW.png',
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
                Icons.refresh,
              ),
              onTap: () {
                setState(() {
                  isLoading = true;
                });

                Timer(Duration(milliseconds: 10), () {
                  setState(() {
                    isLoading = false;
                  });
                });
              },
            ),
          ),
        ],
      ),
      body: SnowbankContainer(
        child: isLoading
            ? Container()
            : Column(
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                  emailVerificationSent = true;
                                                                });

                                                                await widget.user.sendEmailVerification().then((_) {
                                                                  var timesChecked = 0;
                                                                  return Timer.periodic(Duration(seconds: 3), (timer) {
                                                                    timesChecked++;

                                                                    if (emailVerified()) {
                                                                      setState(() {
                                                                        emailIsVerified = widget.user.emailVerified;
                                                                        emailVerificationSent = false;

                                                                        timer.cancel();
                                                                      });
                                                                    } else if (timesChecked >= 40) {
                                                                      // 1 minute at 3 second intervals
                                                                      timer.cancel();
                                                                    }
                                                                  });
                                                                });
                                                              },
                                                              color: Color.fromARGB(255, 225, 225, 225),
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
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: FutureBuilder<bool>(
                                          future: hasMembership(),
                                          builder: (context, AsyncSnapshot<bool> snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            } else {
                                              return buildMembershipStatus(snapshot.data);
                                            }
                                          },
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

  Widget buildMembershipStatus(bool hasMembership) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            enabled: false,
            initialValue: !hasMembership ? "No active membership" : "Membership",
            decoration: InputDecoration(
              labelText: "The Pond",
              disabledBorder: InputBorder.none,
            ),
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: !hasMembership
              ? FlatButton(
                  onPressed: () {
                    _launchURL("https://thepond.howtohockey.com");
                  },
                  color: Color.fromARGB(255, 204, 51, 51),
                  child: Text(
                    'activate',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              : FlatButton(
                  onPressed: null,
                  color: Colors.red,
                  child: Text(
                    'active',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
