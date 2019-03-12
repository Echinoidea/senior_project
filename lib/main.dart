import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'pages/quiz_basics_screen.dart';
import 'utils/question.dart';

void main() {
  runApp(new MaterialApp(
    home: new QuizBasicsScreen(),
    //home: new SplashScreen(),
    // home: new HomeScreen(),
  ));
}
