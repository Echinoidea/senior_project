import 'package:flutter/material.dart';
import 'package:senior_project/utils/question.dart';
import 'package:senior_project/ui/answer_button.dart';
import 'package:senior_project/ui/correct_wrong_overlay.dart';
import 'score_screen.dart';

//"日", "月", "火", "水", "木", "金", "土", "本", "犬", "猫"

List<Question> _questions = [
  new Question("日", ["かね", "いぬ", "はし", "にち"], 3),
  new Question("月", ["ねん", "げつ", "はち", "しち"], 1),
  new Question("火", ["とら", "ひと", "ひ", "いち"], 2),
  new Question("水", ["まえ", "みず", "ちち", "きのう"], 1),
  new Question("木", ["かみ", "かね", "き", "なな"], 2),
  new Question("土", ["ど", "にく", "かい", "はは"], 0),
  new Question("本", ["まえ", "ええ", "ねる", "ほん"], 3),
  new Question("金", ["かね", "おき", "しち", "ねこ"], 0),
  new Question("犬", ["いぬ", "きく", "はち", "いい"], 0),
  new Question("猫", ["おお", "なれ", "ねこ", "じゃ"], 2),
];

int _currentQuestionIndex = -1;
int _questionNumber = -1;
Question _currentQuestion;// = new Question("", [], 0);
int _score = 0;
bool _overlayShouldBeVisible = false;
bool _isCorrect = false;
String _questionText = "X";



bool _isChoiceCorrect(int index) {
  if (index == _currentQuestion.correctIndex) {
    return true;
  } else {
    return false;
  }
}


class QuizBasicsScreen extends StatefulWidget {
  @override
  _QuizBasicsScreenState createState() => new _QuizBasicsScreenState();
}

class _QuizBasicsScreenState extends State<QuizBasicsScreen> {

  void _handleAnswer(int answer) {
    /*if (answer == _currentQuestion.correctIndex) {
      debugPrint("Correct");
      _isCorrect = true;
      _score++;
      try {
        if (_currentQuestionIndex >= _questions.length) {
          _currentQuestionIndex = -1;
          _displayScoreScreen();
        } else {
          _currentQuestionIndex++;
          _currentQuestion = _getNextQuestion();
        }
      } catch (Exception) {
        debugPrint("Error");
      }
    } else {
      debugPrint("Incorrect");
      _isCorrect = false;
    }

    this.setState(() {
      _overlayShouldBeVisible = true;
    });*/
    _isCorrect = answer == _currentQuestion.correctIndex ? true : false;
    this.setState(() {
      if (_isCorrect && _getNextQuestion() != null) {
        _score++;
        _questionNumber = _currentQuestionIndex++;
        _currentQuestion = _getNextQuestion();
      }
      _overlayShouldBeVisible = true;
    });
  }

  @override
  void initState() {
    super.initState();

    _currentQuestion = _getNextQuestion();
    _questionNumber = _currentQuestionIndex;
    _questionText = _currentQuestion.questionText;
  }

  void _displayScoreScreen() {
    Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
        builder: (BuildContext context) => new ScoreScreen(
            _score, _questions.length
        )
    ), (Route route) => route == null
    );
  }
  Question _getNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      return _questions[_currentQuestionIndex + 1];
    }/* else {
      _currentQuestion = _questions.last;
      //_displayScoreScreen();
    }*/
  }

  Widget _getQuestionText() {
    try {
      return Text(
        "Select '${_currentQuestion.questionText}'",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40.0,
          color: Colors.red,
        ),
      );
    } catch (Exception) {
      return Text("");
    }
  }

  List<Widget> _questionChildren() {
    List<Widget> children;
    if (_questionNumber < _questions.length) {

      children.add(new Padding(
          padding: EdgeInsets.only(top: 30.0)
      ));
      children.add(_getQuestionText());
      children.add(new Padding(
          padding: EdgeInsets.only(top: 30.0)
      ));
      children.add(new AnswerButton(
          _currentQuestion.choices[0],
          _isChoiceCorrect(_currentQuestion.correctIndex),
              () => _handleAnswer(0)
      ));
      children.add(new AnswerButton(
          _currentQuestion.choices[1],
          _isChoiceCorrect(_currentQuestion.correctIndex),
              () => _handleAnswer(1)
      ));
      children.add(new AnswerButton(
          _currentQuestion.choices[2],
          _isChoiceCorrect(_currentQuestion.correctIndex),
              () => _handleAnswer(2)
      ));
      children.add(new AnswerButton(
          _currentQuestion.choices[3],
          _isChoiceCorrect(_currentQuestion.correctIndex),
              () => _handleAnswer(3)
      ));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: _questionChildren()
          ),
          _overlayShouldBeVisible == true ? new CorrectWrongOverlay(
            _isCorrect,
              () {
              /*if (_currentQuestionIndex > _questions.length - 1) {
                Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
                    builder: (BuildContext context) => new ScoreScreen(
                        _score, _questions.length
                    )
                ), (Route route) => route == null
                );
              } else if (_currentQuestion != _questions.last) {
                _currentQuestion = _getNextQuestion();
                this.setState(() {
                  _overlayShouldBeVisible = false;
                  _questionNumber++;
                });
              } else {
                this.setState(() {
                  _overlayShouldBeVisible = false;
                });
              }*/
                if (_questions.length == _questionNumber) {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                      builder: (BuildContext context) => ScoreScreen(
                          _score, _questions.length
                      )
                  ), (Route route) => route == null
                  );
                  return;
                }
                _currentQuestion = _getNextQuestion();
                this.setState(() {
                  _overlayShouldBeVisible = false;
                  _questionText = _currentQuestion.questionText;
                  _questionNumber = _questionNumber;
                });
            }
          ) : new Container()
        ],
      )
    );
  }
}

// TODO: On click answerbutton if correct then display overlay and continue. Add score to total score.