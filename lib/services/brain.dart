import 'package:homeless/packages.dart';

class QuizBrain {
  int _questionNumber = 0;

  final List<Question> questionBank = [
    Question('Over half a million people are homeless.', true),
    Question('One quarter of homeless people are children.', true),
    Question(
        'Domestic violence isn\'t a leading cause of homelessness among women.',
        false),
    Question('Many people are homeless because they cannot afford rent.', true),
    Question(
        'One in five homeless people suffers from untreated severe mental illness.',
        true),
    Question('Cities are increasingly making homelessness a crime.', true),
  ];

  void nextQuestion() {
    if (_questionNumber < questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return questionBank[_questionNumber].question;
  }

  bool getCorrectAnswer() {
    return questionBank[_questionNumber].answer;
  }
}
