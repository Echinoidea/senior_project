import 'package:flutter/material.dart';
import 'package:senior_project/utils/question.dart';
import 'package:senior_project/ui/answer_button.dart';
import 'package:senior_project/ui/correct_wrong_overlay.dart';
import 'score_screen.dart';
import 'dart:collection';

class QuizBasicsScreen extends StatefulWidget {
  @override
  _QuizBasicsScreenState createState() => new _QuizBasicsScreenState();
}

class _QuizBasicsScreenState extends State<QuizBasicsScreen> {

  static final List<Question> _questionList = [
    new Question("日", ["かね; Money", "いぬ; Dog", "はし; Chopsticks", "にち; Sun"], 3),
    new Question("月", ["ねん; Year", "げつ; Month", "はち; Eight", "しち; Seven"], 1),
    new Question("火", ["とら; Tiger", "ひと; Person", "ひ; Fire", "いち; One"], 2),
    new Question("水", ["まえ; Before", "みず; Water", "ちち; Dad", "きのう; Yesterday"], 1),
    new Question("木", ["かみ; Paper", "かね; Money", "き; Tree", "あう; Blue"], 2),
    new Question("土", ["ど; Earth", "にく; Meat", "かい; Shellfish", "はは; Mom"], 0),
    new Question("本", ["まえ; Before", "ええ; Yeah", "ねる; To sleep", "ほん; Book"], 3),
    new Question("金", ["かね; Money", "おきる; To get up", "しち; Seven", "ねこ; Cat"], 0),
    new Question("犬", ["いぬ; Dog", "きく; To hear", "はち; Eight", "いい; Good"], 0),
    new Question("猫", ["おおき; Big", "はし; Chopsticks", "ねこ; Cat", "ひ; Fire"], 2),
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