import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login.dart';
import 'SignIn.dart';
import 'ShotCard.dart';

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
  bool isSignedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  CircleAvatar profileAvatar = CircleAvatar(
    radius: 40,
    backgroundImage: AssetImage("/assets/images/placeholder-avatar.png"),
    backgroundColor: Colors.transparent,
  );

  @override
  Widget build(BuildContext context) {
    if (!isSignedIn()) {
      signOut();
      return Login();
    } else {
      profileAvatar = CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(
          FirebaseAuth.instance.currentUser.providerData[0].photoURL,
        ),
        backgroundColor: Colors.transparent,
      );
    }

    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Container(
          child: widget.logo != null
              ? widget.logo
              : Image(
                  height: 45,
                  image: AssetImage(
                    'assets/images/logo/THEPOND_RGB_WHITE_WORDMARK_RAW.png',
                  ),
                ),
        ),
        actions: [
          Container(
              height: 40,
              width: 55,
              padding: EdgeInsets.all(5),
              child: GestureDetector(
                child: profileAvatar,
                onTap: () {
                  _scaffoldKey.currentState.openEndDrawer();
                },
              ))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/snowbank.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomRight,
          ),
        ),
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
      endDrawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Image(
                  height: 150,
                  image: AssetImage(
                      'assets/images/logo/THEPOND_WHITE_SNOWBANK.png'),
                ),
              ),
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
            ),
            ListTile(
              title: Text('My Profile'),
              trailing: profileAvatar,
              onTap: () {
                //Do something

                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              title: Text('Logout'),
              trailing: Icon(Icons.exit_to_app),
              onTap: () {
                signOut();

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return Login();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
