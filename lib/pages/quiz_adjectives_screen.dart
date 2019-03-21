import 'package:flutter/material.dart';
import 'package:senior_project/utils/question.dart';
import 'package:senior_project/ui/answer_button.dart';
import 'package:senior_project/ui/correct_wrong_overlay.dart';
import 'score_screen.dart';
import 'dart:collection';

class QuizAdjectivesScreen extends StatefulWidget {
  @override
  _QuizAdjectivesScreenState createState() => new _QuizAdjectivesScreenState();
}

class _QuizAdjectivesScreenState extends State<QuizAdjectivesScreen> {

  static final List<Question> _questionList = [
    new Question("暖かい", ["あたたかい; Warm", "まえ; Before", "はし; Chopsticks", "にち; Sun"], 0),
    new Question("暑い", ["ねん; Year", "げつ; Month", "あつい; Hot", "かえる; Return"], 2),
    new Question("寒い", ["むすめ; Daughter", "ひと; Person", "さむい; Cold", "いち; One"], 2),
    new Question("涼しい", ["すずしい; Cool", "かんじ; Chinese characters", "ときょう; Tokyo", "きのう; Yesterday"], 0),
    new Question("大きい", ["かわいい; Cute", "あたたかい; Warm", "おにい; Older brother", "おおきい; Big"], 3),
    new Question("小さい", ["ど; Earth", "にく; Meat", "ちいさい; Small", "あたたかい; Warm"], 2),
    new Question("可愛い", ["かわいい; Cute", "ええ; Yeah", "ちゅうごく; China", "ほん; Book"], 2),
    new Question("綺麗", ["きれい; Beautiful", "わたし; I/Me", "あなた; You", "かわいい; Cute"], 0),
    new Question("思い", ["おもい; Heavy", "きく; To hear", "せんせい; Teacher", "いい; Good"], 0),
    new Question("良い", ["おおき; Big", "なれ; Practice", "ねこ; Cat", "よい; Good"], 3),
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