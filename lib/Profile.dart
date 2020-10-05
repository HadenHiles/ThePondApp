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
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                child: ListView(
                  children: [
                    Card(
                      child: ListTile(
                        leading: Container(
                          height: double.infinity,
                          child: UserAvatar(),
                        ),
                        title: Container(
                          padding: EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                          ),
                          child: Text(
                            widget.user.displayName,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.link,
                          size: 32,
                        ),
                        title: Text('Link Accounts'),
                        subtitle: Text('Connect other sign in methods'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
