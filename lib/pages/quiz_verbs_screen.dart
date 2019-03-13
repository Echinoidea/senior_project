import 'package:flutter/material.dart';
import 'package:senior_project/utils/question.dart';
import 'package:senior_project/ui/answer_button.dart';
import 'package:senior_project/ui/correct_wrong_overlay.dart';
import 'score_screen.dart';
import 'dart:collection';

class QuizVerbsScreen extends StatefulWidget {
  @override
  _QuizVerbsScreenState createState() => new _QuizVerbsScreenState();
}

class _QuizVerbsScreenState extends State<QuizVerbsScreen> {

  static final List<Question> _questionList = [
    new Question("食べ", ["たべる", "いぬ", "ねる", "おおきい"], 0),
    new Question("寝る", ["ねん", "ねる", "ちゅうごく", "しち"], 1),
    new Question("飲む", ["のむ", "おきる", "おまえ", "いち"], 0),
    new Question("出かける", ["でかける", "みず", "です", "きのう"], 0),
    new Question("起きる", ["かみ", "おきる", "聞く", "なな"], 1),
    new Question("来る", ["くる", "おとこ", "かい", "ひと"], 0),
    new Question("掃除する", ["リンゴ", "そうじする", "にほんご", "ほん"], 1),
    new Question("見る", ["かね", "みる", "そうじする", "アメリカ"], 1),
    new Question("読む", ["よい", "きく", "あたたかい", "よみ"], 3),
    new Question("買う", ["おお", "はい", "さむい", "かう"], 3),
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