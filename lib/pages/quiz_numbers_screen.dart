import 'package:flutter/material.dart';
import 'package:senior_project/utils/question.dart';
import 'package:senior_project/ui/answer_button.dart';
import 'package:senior_project/ui/correct_wrong_overlay.dart';
import 'score_screen.dart';
import 'dart:collection';

class QuizNumbersScreen extends StatefulWidget {
  @override
  _QuizNumbersScreenState createState() => new _QuizNumbersScreenState();
}

class _QuizNumbersScreenState extends State<QuizNumbersScreen> {

  static final List<Question> _questionList = [
    new Question("一", ["かね", "いち", "はし", "にち"], 1),
    new Question("二", ["ねん", "げつ", "に", "しち"], 2),
    new Question("三", ["さん", "ひと", "ひ", "いち"], 0),
    new Question("四", ["まえ", "みず", "ちち", "よん；し"], 3),
    new Question("五", ["かみ", "かね", "き", "ご"], 3),
    new Question("六", ["ど", "にく", "ろく", "はは"], 2),
    new Question("七", ["まえ", "しち；なな", "ねる", "ほん"], 1),
    new Question("八", ["かね", "おき", "しち", "はち"], 3),
    new Question("九", ["いぬ", "きく", "はち", "きゅう"], 3),
    new Question("十", ["じゅう", "なれ", "ねこ", "じゃ"], 0),
    new Question("", ["", "", "", ""], 0)
  ];

  var _questionQueue = new Queue<Question>.from(_questionList);

  Question _currentQuestion;

  int _score = 0;

  bool _overlayShouldBeVisible = false;
  bool _isCorrect = false;

  void _handleAnswer(int selected) {

    if (selected == _currentQuestion.correctIndex) {
      _isCorrect = true;
    }
    else {
      _isCorrect = false;
    }

    if (_isCorrect) {
      _score++;
      debugPrint("Correct");
    }
    else {
      debugPrint("Wrong");
    }

    _currentQuestion = _getNextQuestion();

    this.setState(() {
      _overlayShouldBeVisible = true;
      if (_questionQueue.isEmpty) {
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
              builder: (BuildContext context) =>
              new ScoreScreen(
                  _score, 10
              ),
            ), (Route route) => route == null
        );
      }
    });
  }

  List<Widget> _createChildren() {
    List<Widget> list = [];
    int num = 0;
    setState(() {
      if (_questionQueue.isNotEmpty) {
        list.add(Text(
          _currentQuestion.questionText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
            color: Colors.red,
          ),
        ));

        list.add(
            AnswerButton(
                _currentQuestion.choices[0],
                3,
                    () => _handleAnswer(0)
            )
        );

        list.add(
            AnswerButton(
                _currentQuestion.choices[1],
                1,
                    () => _handleAnswer(1)
            )
        );

        list.add(
            AnswerButton(
                _currentQuestion.choices[2],
                num,
                    () => _handleAnswer(2)
            )
        );

        list.add(
            AnswerButton(
                _currentQuestion.choices[3],
                num,
                    () => _handleAnswer(3)
            )
        );
      }
    });
    return list;
  }

  @override
  initState() {
    super.initState();
    _currentQuestion = _getNextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              children: _createChildren(),
            ),
            (_overlayShouldBeVisible == true ? new CorrectWrongOverlay(
                _isCorrect,
                    () {
                  if (_questionQueue.isEmpty) {
                    Navigator.of(context).pushAndRemoveUntil(
                        new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new ScoreScreen(
                              _score, 10
                          ),
                        ), (Route route) => route == null
                    );
                    this.setState(() {
                      _overlayShouldBeVisible = true;
                    });
                  }
                  else {
                    this.setState(() {
                      _overlayShouldBeVisible = false;
                    });
                  }
                }) : new Container())
          ],
        )
    );
  }


  Question _getNextQuestion() {
    Question q;
    if (_questionQueue.isNotEmpty) {
      q = _questionQueue.removeFirst();
    }
    else {
      debugPrint("Queue is empty");
    }

    return q;
  }
}