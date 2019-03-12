import 'package:flutter/material.dart';
import 'package:senior_project/utils/question.dart';
import 'package:senior_project/ui/answer_button.dart';
import 'package:senior_project/ui/correct_wrong_overlay.dart';
import 'score_screen.dart';
import 'dart:collection';

//"日", "月", "火", "水", "木", "金", "土", "本", "犬", "猫"

/*List<Question> _questions = [
  new Question("日", ["かね", "いぬ", "はし", "にち"], 3),
  new Question("月", ["ねん", "げつ", "はち", "しち"], 1),
  new Question("火", ["とら", "ひと", "ひ", "いち"], 2),
  /*new Question("水", ["まえ", "みず", "ちち", "きのう"], 1),
  new Question("木", ["かみ", "かね", "き", "なな"], 2),
  new Question("土", ["ど", "にく", "かい", "はは"], 0),
  new Question("本", ["まえ", "ええ", "ねる", "ほん"], 3),
  new Question("金", ["かね", "おき", "しち", "ねこ"], 0),
  new Question("犬", ["いぬ", "きく", "はち", "いい"], 0),
  new Question("猫", ["おお", "なれ", "ねこ", "じゃ"], 2),*/
];*/
/*
int _currentQuestionIndex = -1;
int _questionNumber = 1;
Question _currentQuestion;// = new Question("", [], 0);
int _score = 0;
bool _overlayShouldBeVisible = false;
bool _isCorrect = false;
String _questionText = "X";*/


/*
bool _isChoiceCorrect(int index) {
  if (index == _currentQuestion.correctIndex) {
    return true;
  } else {
    return false;
  }
}*/

Question q1 = new Question("日", ["かね", "いぬ", "はし", "にち"], 3);
Question q2 = new Question("月", ["ねん", "げつ", "はち", "しち"], 1);
Question q3 = new Question("火", ["とら", "ひと", "ひ", "いち"], 2);

class Tuple<A, B> {
  A a;
  B b;

  Tuple(this.a, this.b);
}

class QuizBasicsScreen extends StatefulWidget {
  @override
  _QuizBasicsScreenState createState() => new _QuizBasicsScreenState();
}

class _QuizBasicsScreenState extends State<QuizBasicsScreen> {

  /*static final List<Question> _questions = [
    q1,
    q2,
    q3
    /*new Question("水", ["まえ", "みず", "ちち", "きのう"], 1),
      new Question("木", ["かみ", "かね", "き", "なな"], 2),
      new Question("土", ["ど", "にく", "かい", "はは"], 0),
      new Question("本", ["まえ", "ええ", "ねる", "ほん"], 3),
      new Question("金", ["かね", "おき", "しち", "ねこ"], 0),
      new Question("犬", ["いぬ", "きく", "はち", "いい"], 0),
      new Question("猫", ["おお", "なれ", "ねこ", "じゃ"], 2),*/
  ];*/

  var _questionQueue = new Queue<Question>();


  int _currentIndex = 0;
  Question _currentQuestion;

  int _score = 0;

  bool _overlayShouldBeVisible = false;
  bool _isCorrect = false;

  @override
  initState() {
    super.initState();
    _questionQueue.addLast(q1);
    _questionQueue.addLast(q2);
    _questionQueue.addLast(q3);
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
              children: <Widget>[
                Text(
                  _getNextQuestion().questionText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    color: Colors.red,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 30.0)
                ),
                AnswerButton(
                  _getNextQuestion().choices[0],
                      () => _handleAnswer(0),
                ),
                AnswerButton(
                  _getNextQuestion().choices[1],
                      () => _handleAnswer(1),
                ),
                AnswerButton(
                  _getNextQuestion().choices[2],
                      () => _handleAnswer(2),
                ),
                AnswerButton(
                  _getNextQuestion().choices[3],
                      () => _handleAnswer(3),
                ),
              ],
            ),
            _overlayShouldBeVisible == true ? new CorrectWrongOverlay(
                _isCorrect,
                    () {
                  if (_currentIndex + 1 > _questionQueue.length) {
                    Navigator.of(context).pushAndRemoveUntil(
                        new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new ScoreScreen(
                              _score, _questionQueue.length
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
                }) : new Container()
          ],
        )
    );
  }


  Question _getNextQuestion() {
    return _questionQueue.removeFirst();
  }

  void _handleAnswer(int selected) {
    if (selected == _currentQuestion.correctIndex && _currentQuestion != _questionQueue.last) {
      _score++;
      //_currentQuestion = _getNextQuestion();
      debugPrint("Correct");
    }
    else {
     // _currentQuestion = _getNextQuestion();
      debugPrint("Wrong");
    }

    setState(() {
      _overlayShouldBeVisible = true;
    });
  }



}

// TODO: On click answerbutton if correct then display overlay and continue. Add score to total score.
