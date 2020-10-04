import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thepondapp/PrimaryScaffold.dart';
import 'package:thepondapp/SnowbankContainer.dart';
import 'package:thepondapp/UserAvatar.dart';

class Profile extends StatefulWidget {
  Profile({Key key, this.user}) : super(key: key);

  final User user;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: SnowbankContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 20,
              ),
              height: 160,
              child: UserAvatar(),
            ),
            Center(
              child: Text(
                widget.user.displayName,
                style: TextStyle(
                  height: 2,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
