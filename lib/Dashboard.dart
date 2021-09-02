import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thepondapp/SkillsVault.dart';
import 'package:thepondapp/widgets/PrimaryScaffold.dart';
import 'package:thepondapp/Login.dart';
import 'package:thepondapp/services/auth.dart';
import 'package:thepondapp/widgets/SnowbankContainer.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  WebViewController _webController;

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
        child: SkillsVault(),
      ),
    );
  }
}
