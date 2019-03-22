import 'package:flutter/material.dart';
import 'package:senior_project/utils/question.dart';
import 'package:senior_project/ui/answer_button.dart';
import 'package:senior_project/ui/correct_wrong_overlay.dart';
import 'score_screen.dart';
import 'dart:collection';
import 'package:audioplayers/audio_cache.dart';

class QuizNumbersScreen extends StatefulWidget {
  @override
  _QuizNumbersScreenState createState() => new _QuizNumbersScreenState();
}

class _QuizNumbersScreenState extends State<QuizNumbersScreen> {

  static final List<Question> _questionList = [
    new Question("一", ["かね; Money", "いち; One", "はし; Chopsticks", "にち; Sun"], 1),
    new Question("二", ["ねん; Year", "げつ; Month", "に; Two", "しち; Seven"], 2),
    new Question("三", ["さん; Three", "ひと; Person", "ひ; Fire", "いち; One"], 0),
    new Question("四", ["まえ; Before", "みず; Water", "ちち; Dad", "よん; Four"], 3),
    new Question("五", ["いち; One", "に; Two", "き; Tree", "ご; Five"], 3),
    new Question("六", ["ど; Earth", "ろく; Six", "じゅう; Ten", "はは; Mom"], 2),
    new Question("七", ["はち; Eight", "しち; Seven", "ねる; To sleep", "ほん; Book"], 1),
    new Question("八", ["かね; Money", "おおき; Big", "しち; Seven", "はち; Eight"], 3),
    new Question("九", ["いぬ; Dog", "じゅう; Ten", "はち; Eight", "きゅう; Nine"], 3),
    new Question("十", ["じゅう; Ten", "ろく; Six", "ねこ; Cat", "ひ; Fire"], 0),
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