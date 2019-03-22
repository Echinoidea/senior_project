import 'package:flutter/material.dart';
import 'package:senior_project/utils/question.dart';
import 'package:senior_project/ui/answer_button.dart';
import 'package:senior_project/ui/correct_wrong_overlay.dart';
import 'score_screen.dart';
import 'dart:collection';
import 'package:audioplayers/audio_cache.dart';

/// All Quiz screens are almost identical to this one. A Quiz contains 10 questions,
/// each question contains 4 possible answers to choose from. When the user selects
/// a button, it will display an overlay with an animation that says if they were
/// correct or not and plays an audio file. Once all the questions have been answered,
/// it displays ScoreScreen, then navigates to HomeScreen again.
class QuizBasicsScreen extends StatefulWidget {
  @override
  _QuizBasicsScreenState createState() => new _QuizBasicsScreenState();
}

class _QuizBasicsScreenState extends State<QuizBasicsScreen> {

  // This is the list of each question, and each choice within that question.
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

  // This is a queue that takes the data from the list above.
  var _questionQueue = new Queue<Question>.from(_questionList);

  // The current question
  Question _currentQuestion;

  // How many correct answers the user has
  int _score = 0;

  // Should the correct/wrong overlay be visible?
  bool _overlayShouldBeVisible = false;

  // Is the user's answer correct?
  bool _isCorrect = false;

  // This is the object used to play the correct / incorrect sfx
  final AudioCache _audioCache = new AudioCache();

  /// Play the correct_sfx.wav file.
  _playCorrect() async {
    await _audioCache.play("correct_sfx.wav");
  }

  /// Play the incorrect_sfx.wav file.
  _playIncorrect() async {
    await _audioCache.play("incorrect_sfx.wav");
  }


  /// This runs each time a button is pressed. It checks if the selected choice
  /// is the correct answer or not. If it is, it plays the respective sound effect,
  /// increases _score by one, sets the current question to the next question en
  /// queue, and checks whether the overlay should be displayed, or if the quiz
  /// queue is empty, it will navigate to the score screen and end the quiz.
  void _handleAnswer(int selected) {

    // Check if the selected answer is correct then plays the sfx.
    if (selected == _currentQuestion.correctIndex) {
      _isCorrect = true;
      _playCorrect();
    }
    else {
      _isCorrect = false;
      _playIncorrect();
    }

    // Increases score by one.
    if (_isCorrect) {
      _score++;
      debugPrint("Correct");
    }
    else {
      debugPrint("Wrong");
    }

    // Gets the next question en queue.
    _currentQuestion = _getNextQuestion();

    /// Sets the current state again and check which page to navigate to next.
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

  /// This creates the layout and objects within with behavior depending on the
  /// current question.
  List<Widget> _createChildren() {
    List<Widget> list = [];
    int num = 0;
    /// If the queue is not empty, add the design objects to the list of children
    /// to be displayed.
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

        // Add each button to the layout in a stack.
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
          // Check if the overlay should be visible if the user is correct or not.
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

  /// Get the next question en queue.
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