import 'package:flutter/material.dart';
import 'quiz_basics_screen.dart';
import 'quiz_adjectives_screen.dart';
import 'quiz_numbers_screen.dart';
import 'quiz_verbs_screen.dart';

/// The HomeScreen contains the buttons that navigate to each respective quiz.
/// When the quiz is done, the user will return to this page.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  /// Each of these methods are used to navigate to its respective quiz page.
  void _navToBasics() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizBasicsScreen()),
    );
  }

  void _navToNumbers() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuizNumbersScreen())
    );
  }

  void _navToAdjectives() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuizAdjectivesScreen())
    );
  }

  void _navToVerbs() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuizVerbsScreen())
    );
  }


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
                  onTap: _navToBasics,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                          width: 5.0,
                        ),
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
                  onTap: _navToNumbers,
                    child: Center(
                      child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                        color: Colors.red,
                        width: 5.0,
                        ),
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
                    padding: EdgeInsets.only
                    (top: 30.0)
                  ),
                InkWell(
                  onTap: _navToAdjectives,
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
                  onTap: _navToVerbs,
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
