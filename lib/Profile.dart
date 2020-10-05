import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thepondapp/LinkAccounts.dart';
import 'package:thepondapp/PrimaryScaffold.dart';
import 'package:thepondapp/SnowbankContainer.dart';
import 'package:thepondapp/UserAvatar.dart';
import 'package:thepondapp/LinkAccounts.dart';

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
            Container(
              padding: EdgeInsets.only(top: 50),
              child: Card(
                elevation: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FractionalTranslation(
                      translation: Offset(-0.36, -0.4),
                      child: Align(
                        child: SizedBox(
                          height: 100,
                          child: UserAvatar(),
                        ),
                        alignment: FractionalOffset(0.5, 0.0),
                      ),
                    ),
                    FractionalTranslation(
                      translation: Offset(0.0, -2.0),
                      child: Align(
                        child: SizedBox(
                          height: 18,
                          child: ListTile(
                            title: Text(
                              widget.user.displayName,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        alignment: FractionalOffset(0.5, 0.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView(
                  children: [
                    Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return LinkAccounts();
                          }));
                        },
                        leading: Icon(
                          Icons.link,
                          size: 32,
                        ),
                        title: Text('Link Account'),
                        subtitle: Text('Connect another sign in method'),
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
