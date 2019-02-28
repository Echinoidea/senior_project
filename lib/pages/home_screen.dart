import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("漢字練習アップリ"),
        actions: <Widget>[
          Padding(
            child: Icon(Icons.arrow_right),
            padding: const EdgeInsets.only(right: 10.0),
          )
        ],
      ),

    );
  }
}