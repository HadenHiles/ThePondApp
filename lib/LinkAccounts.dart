import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LinkAccounts extends StatefulWidget {
  LinkAccounts({Key key}) : super(key: key);

  @override
  _LinkAccountsState createState() => _LinkAccountsState();
}

class _LinkAccountsState extends State<LinkAccounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: [
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Link Accounts:',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            height: 2,
                          ),
                        ),
                        Divider(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SignInButton(
                              Buttons.Google,
                              onPressed: () {},
                            ),
                            SignInButton(
                              Buttons.Facebook,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
