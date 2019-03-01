import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 30.0)
                ),
                Text(
                  "日本語練習",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.red,
                  ),
                ),
                Text(
                  "Japanese Practice",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.redAccent,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 30.0)
                ),
                InkWell(
                  onTap: null, // TODO: Navigate to respective quiz page
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                          width: 5.0,
                        )
                      ),
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Basics",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.redAccent
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 30.0)
                ),
                InkWell(
                  onTap: null, // TODO: Navigate to respective quiz page
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                          width: 5.0,
                        )
                      ),
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Numbers",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.redAccent
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0)
                ),
                InkWell(
                  onTap: null, // TODO: Navigate to respective quiz page
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                          width: 5.0,
                        )
                      ),
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Adjectives",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.redAccent
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0)
                ),
                InkWell(
                  onTap: null, // TODO: Navigate to respective quiz page
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                          width: 5.0,
                        )
                      ),
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Verbs",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.redAccent
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
