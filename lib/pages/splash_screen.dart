import 'package:flutter/material.dart';
import 'dart:async';
import 'home_screen.dart';

/// SplashScreen is the first page to be displayed. It remains on screen for 3
/// seconds, then navigates to HomeScreen.
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait 3 seconds before navigating to HomeScreen.
    Timer(Duration(seconds: 3), () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen())
      )
    );
  }

  /// This build actual layout of the SplashScreen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white70),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "日本語",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: Colors.redAccent,
                        ),
                      ),
                      Text(
                        "By Gabriel Hooks",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ),
        ]
      ),
    );
  }
}