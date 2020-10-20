import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thepondapp/Dashboard.dart';
import 'package:thepondapp/Account.dart';
import 'package:thepondapp/Login.dart';
import 'package:thepondapp/auth.dart';
import 'package:thepondapp/widgets/UserAvatar.dart';

class PrimaryScaffold extends StatefulWidget {
  PrimaryScaffold({Key key, this.body, this.snackbar}) : super(key: key);

  final Widget body;
  final Widget snackbar;

  @override
  _PrimaryScaffoldState createState() => _PrimaryScaffoldState();
}

class _PrimaryScaffoldState extends State<PrimaryScaffold> {
  // Auth variables
  FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;

  // Scaffold key
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            height: 40,
            width: 55,
            padding: EdgeInsets.all(5),
            child: InkWell(
              child: Icon(
                Icons.menu,
              ),
              onTap: () {
                _scaffoldKey.currentState.openEndDrawer();
              },
            ),
          ),
        ],
      ),
      body: widget.body,
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
              title: Text('My Account'),
              trailing: UserAvatar(),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Account(
                    user: user,
                  );
                }));
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
