import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => print("End Splash Screen"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.redAccent),
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
                      Ink(
                        decoration: ShapeDecoration(
                          shape: Border.all(
                            color: Colors.white,
                            width: 8.0
                          ),
                        ),
                        child: Column(
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
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ]
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
/*/*
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 100.0,
                          child: Icon(
                            Icons.brightness_1,
                            color: Colors.red,
                            size: 50.0,
                          ),
                        ),*/

                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        )*/