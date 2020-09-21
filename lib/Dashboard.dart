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
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
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
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                FirebaseAuth.instance.currentUser.photoURL,
              ),
              backgroundColor: Colors.transparent,
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/snowbank.png'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomRight),
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
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
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
              trailing: CircleAvatar(
                backgroundImage:
                    NetworkImage(FirebaseAuth.instance.currentUser.photoURL),
              ),
              onTap: () {
                //Do something

                // Then close the drawer
                Navigator.pop(context);
              },
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
