class Question {
  String questionText = "";
  List<String> choices = new List<String>();
  int correctIndex = 0;

  Question(questionText, choices, correctIndex) {
    this.questionText = questionText;
    this.choices = choices;
    if (this.choices.isEmpty || this.choices == null) {
      this.choices = ["", "", "", "",];
    }
    this.correctIndex = correctIndex;
  }
}