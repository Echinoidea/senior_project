import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget{
  String _buttonText = ".";
  VoidCallback _onTap;

  AnswerButton(_buttonText, _correctIndex, _onTap) {
    this._buttonText = _buttonText;
    this._onTap = _onTap;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: _onTap,
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
                _buttonText,
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

