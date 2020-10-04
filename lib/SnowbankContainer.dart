import 'package:flutter/material.dart';

class SnowbankContainer extends StatelessWidget {
  SnowbankContainer({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/snowbank.png'),
          fit: BoxFit.fitWidth,
          alignment: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}
