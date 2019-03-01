import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget{
  String text = "null";
  bool isCorrect = false;

  AnswerButton(questionText, isCorrect);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: new InkWell(
          onTap: null, // TODO: Create event
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                  width: 5.0,
                ),
              ),
              padding: EdgeInsets.all(20.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

