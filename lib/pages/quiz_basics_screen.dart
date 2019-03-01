import 'package:flutter/material.dart';
import 'package:senior_project/utils/question.dart';
import 'package:senior_project/ui/answer_button.dart';

//"日", "月", "火", "水", "木", "金", "土", "本", "犬", "猫"

List<Question> _questions = [
  new Question(
    "日",
    <String> [
      "かね",
      "いぬ",
      "はし",
      "にち"
    ],
  ),
];

int _currentQuestionIndex = 0;

Question _getNextQuestion() {
  return _questions[_currentQuestionIndex + 1];
}

class QuizBasicsScreen extends StatefulWidget {
  @override
  _QuizBasicsScreenState createState() => new _QuizBasicsScreenState();
}

class _QuizBasicsScreenState extends State<QuizBasicsScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 30.0)
          ),
          Text(
            "Select '${_getNextQuestion().questionText}" + "'",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40.0,
              color: Colors.red,
            ),
          ),
          AnswerButton(
            _getNextQuestion().questionText,
            false
          ),

        ],
      ),
    );
  }
}

// TODO: On click answerbutton if correct then display overlay and continue. Add score to total score.