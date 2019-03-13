class Question {
  String questionText = "";
  var choices = [];
  int correctIndex = 0;

  Question(questionText, choices, correctIndex) {
    this.questionText = questionText;
    this.choices = choices;
    this.correctIndex = correctIndex;
  }
}