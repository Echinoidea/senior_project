import 'package:flutter/material.dart';
import 'package:senior_project/utils/question.dart';
import 'package:senior_project/ui/answer_button.dart';
import 'package:senior_project/ui/correct_wrong_overlay.dart';
import 'score_screen.dart';
import 'dart:collection';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

class QuizVerbsScreen extends StatefulWidget {
  @override
  _QuizVerbsScreenState createState() => new _QuizVerbsScreenState();
}

class _QuizVerbsScreenState extends State<QuizVerbsScreen> {

  static final List<Question> _questionList = [
    new Question("食べ", ["たべる; To eat", "いぬ; Dog", "ねる; To sleep", "おおき; Big"], 0),
    new Question("寝る", ["ねん; Year", "ねる; To sleep", "ちゅうごく; China", "しち; Seven"], 1),
    new Question("飲む", ["のむ; To drink", "おきる; To get up", "でかける; To go out", "いち; One"], 0),
    new Question("出かける", ["でかける; To go out", "みず; Water", "です; To be", "きのう; Yesterday"], 0),
    new Question("起きる", ["ねこ; Cat", "おきる; To get up", "聞く; To listen", "しち; Seven"], 1),
    new Question("来る", ["くる; To come", "おとこ; Man", "パソコン; Computer", "ひと; Person"], 0),
    new Question("掃除する", ["リンゴ; Apple", "そうじする; To clean", "にほんご; Japanese", "ほん; Book"], 1),
    new Question("見る", ["かね; Money", "みる; To see", "そうじする; To clean", "アメリカ; America"], 1),
    new Question("読む", ["よい; Good", "きく; To hear", "あたたかい; Warm", "よみ; Read"], 3),
    new Question("買う", ["おきる; To get up", "はい; Yes", "さむい; Cool", "かう; To buy"], 3),
    new Question("", ["", "", "", ""], 0)
  ];

  var _questionQueue = new Queue<Question>.from(_questionList);

  Question _currentQuestion;

  int _score = 0;

  bool _overlayShouldBeVisible = false;
  bool _isCorrect = false;

  final AudioCache _audioCache = new AudioCache();

  _playCorrect() async {
    await _audioCache.play("correct_sfx.wav");
  }

  _playIncorrect() async {
    await _audioCache.play("incorrect_sfx.wav");
  }

  void _handleAnswer(int selected) {

    if (selected == _currentQuestion.correctIndex) {
      _isCorrect = true;
      _playCorrect();
    }
    else {
      _isCorrect = false;
      _playIncorrect();
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