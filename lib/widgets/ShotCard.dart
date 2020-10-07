import 'package:flutter/material.dart';

class ShotCard extends StatelessWidget {
  final VoidCallback onTap;
  final String name;

  ShotCard({this.name, this.onTap, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: this.onTap,
        child: Container(
          child: Center(
            child: Text(this.name),
          ),
        ),
      ),
    );
  }
}
