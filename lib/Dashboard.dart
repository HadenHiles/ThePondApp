import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thepondapp/PrimaryScaffold.dart';
import 'package:thepondapp/Login.dart';
import 'package:thepondapp/SignIn.dart';
import 'package:thepondapp/SnowbankContainer.dart';
import 'package:thepondapp/ShotCard.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.logo}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final Image logo;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Auth variables
  FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;

  // State variables
  bool signedIn = FirebaseAuth.instance.currentUser != null;
  bool emailVerified = FirebaseAuth.instance.currentUser?.emailVerified;

  @override
  Widget build(BuildContext context) {
    if (!signedIn) {
      signOut();
      return Login();
    }

    // Scaffold key
    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
    return PrimaryScaffold(
      key: _scaffoldKey,
      body: SnowbankContainer(
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            ShotCard(
              name: 'Wrist Shot',
              onTap: () {
                print('Wrist Shot card tapped.');
              },
            ),
            ShotCard(
              name: 'Snap Shot',
              onTap: () {
                print('Snap Shot card tapped.');
              },
            ),
            ShotCard(
              name: 'Slap Shot',
              onTap: () {
                print('Slap Shot card tapped.');
              },
            ),
            ShotCard(
              name: 'Backhand',
              onTap: () {
                print('Backhand card tapped.');
              },
            )
          ],
        ),
      ),
    );
  }
}
